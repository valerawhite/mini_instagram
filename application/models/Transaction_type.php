<?php

namespace Model;

class Transaction_type extends \System\Core\Emerald_enum
{
    public const ADDING = 1; //Пополнение баланса пользователя
    public const WITHDRAWN = 2; //Снятие с баланса пользователя
}