<?php

class PaymentTypeSelector
{
    private $productType;
    private $amount;
    private $lang;
    private $countryCode;
    private $userOs;
    private $buttons = [];

    public function __construct(string $productType, float $amount, string $lang, string $countryCode, string $userOs)
    {
        $this->productType = $productType;
        $this->amount = $amount;
        $this->lang = $lang;
        $this->countryCode = $countryCode;
        $this->userOs = $userOs;

        $this->loadButtons();
    }

    public function getButtons(): array
    {
        $response = [];
        if ($this->buttons) {
            foreach ($this->buttons as $button) {
                $response[] = [
                    'name' => $button->name,
                    'commission' => $button->commission,
                    'imageUrl' => $button->img,
                    'payUrl' => $button->link
                ];
            }
        }
        return $response;
    }

    private function loadButtons(): void
    {
        $conditions = $this->conditionsForStatus();
        if ($conditionsForCountryCode = $this->conditionsForCountryCode()) {
            $conditions = array_merge($conditions, $conditionsForCountryCode);
        }
        if ($conditionsForExcludeIds = $this->conditionsForOtherSituations()) {
            $conditions = array_merge($conditions, $conditionsForExcludeIds);
        }
        $joins[] = 'LEFT JOIN payment_system ps ON (pt.payment_system_id = ps.id)';
        $this->buttons = PaymentType::find('all', [
            'from' => 'payment_type as pt',
            'select' => 'pt.*, ps.link',
            'joins' => $joins,
            'conditions' => implode(' AND ', $conditions),
            'order' => 'pt.sort asc'
        ]);
    }

    private function conditionsForStatus(): array
    {
        return [
            sprintf('pt.status = "%s"', PaymentType::STATUS_ACTIVE),
            sprintf('ps.status = "%s"', PaymentSystem::STATUS_ACTIVE)
        ];
    }

    private function conditionsForCountryCode(): array
    {
        $conditions = [];
        if ($country = Country::find_by_code($this->countryCode)) {
            $conditions[] = sprintf('(EXISTS (
                    SELECT * FROM payment_type_country_allow
                    WHERE payment_type_country_allow.payment_type_id = pt.id
                    AND payment_type_country_allow.country_id = %s
                ) OR NOT EXISTS (
                    SELECT * FROM payment_type_country_allow
                    WHERE payment_type_country_allow.payment_type_id = pt.id))', $country->id);
            $conditions[] = sprintf('NOT EXISTS(
                    SELECT * FROM payment_type_country_disallow 
                    WHERE payment_type_country_disallow.payment_type_id = pt.id 
                    AND payment_type_country_disallow.country_id = %s
                )', $country->id);
        }
        return $conditions;
    }

    private function conditionsForOtherSituations(): array
    {
        $conditions = [];
        if ($this->lang == LANG_ES && $this->amount < 0.3 && $this->productType == PRODUCT_TYPE_REWARD) {
            $conditions[] = sprintf('pt.type != "%s"', PaymentType::TYPE_EXTERNAL);
        }
        if ($this->lang == LANG_ES && $this->amount < 0.3) {
            $conditions[] = 'ps.name NOT LIKE "%PayPal%"';
        }
        if ($this->userOs != OS_ANDROID) {
            $conditions[] = 'ps.name NOT LIKE "%GooglePay%"';
        }
        if ($this->userOs != OS_IOS) {
            $conditions[] = 'ps.name NOT LIKE "%ApplePay%"';
        }
        if ($this->productType == PRODUCT_TYPE_WALLET_REFILL) {
            $conditions[] = sprintf('pt.type != "%s"', PaymentType::TYPE_INNER);
        }

        return $conditions;
    }
}