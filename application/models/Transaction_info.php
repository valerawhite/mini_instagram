<?php

namespace Model;

class Transaction_info extends \System\Core\Emerald_enum
{

    public const PURCHASE_BOOSTERPACK_THE_FIRST = 1; // Покупка бустерпака за 5$
    public const PURCHASE_BOOSTERPACK_THE_SECOND = 2; // Покупка бустерпака за 20$
    public const PURCHASE_BOOSTERPACK_THE_THIRD = 3; // Покупка бустерпака за 50$

    public static function getPurchaseBoosterpack($id_package) {
        switch($id_package) {
            case 1:
                return self::PURCHASE_BOOSTERPACK_THE_FIRST;
            break;
            case 2:
                return self::PURCHASE_BOOSTERPACK_THE_SECOND;
            break;
            case 3:
                return self::PURCHASE_BOOSTERPACK_THE_THIRD;
            break;
            default:
                throw new Exception('not constant');
            break;
        }
    }
}