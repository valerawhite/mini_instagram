<?php

namespace Model;

use App;
use CI_Emerald_Model;
use Exception;
use stdClass;


class Transaction_model extends CI_Emerald_Model {
    const CLASS_TABLE = 'transaction';

    /** @var int */
    protected $type;
    /** @var int */
    protected $user_id;
    /** @var float */
    protected $sum;
    /** @var float */
    protected $cur_balance;
    /** @var int */
    protected $info;
    /** @var string */
    protected $time_created;
    /** @var string */
    protected $time_updated;

    function __construct($id = NULL)
    {
        parent::__construct();
        $this->set_id($id);
    }

    public function startTransaction(User_model $user, float $sum, int $type, int $info = null, int $likes = null) {
        $data = [
            'user_id' => $user->get_id(),
            'sum' => $sum,
            'type' => $type,
            'cur_balance' => $user->get_wallet_balance(),
        ];
        if(!empty($info)) $data = array_merge($data, ['info' => $info]);
        if(!empty($likes)) $data = array_merge($data, ['c_likes' => $likes]);
        try {
            self::create($data);
        } catch (\Exception $ex) {
            throw $ex;
        }
    }

    public static function create(array $data)
    {
        App::get_ci()->s->from(self::CLASS_TABLE)->insert($data)->execute();
        return new static(App::get_ci()->s->get_insert_id());
    }

    public function delete()
    {
        $this->is_loaded(TRUE);
        App::get_ci()->s->from(self::CLASS_TABLE)->where(['id' => $this->get_id()])->delete()->execute();
        return (App::get_ci()->s->get_affected_rows() > 0);
    }

    /**
     * @return int
     */
    public function get_type(): int
    {
        return $this->type;
    }

    /**
     * @param int $type
     *
     * @return bool
     */
    public function set_type(int $type)
    {
        $this->type = $type;
        return $this->save('type', $type);
    }

    /**
     * @return int
     */
    public function get_sum(): int
    {
        return $this->sum;
    }

    /**
     * @param int $type
     *
     * @return bool
     */
    public function set_sum(int $sum)
    {
        $this->sum = $sum;
        return $this->save('sum', $sum);
    }

    /**
     * @return float
     */
    public function get_cur_balance(): float
    {
        return $this->cur_balance;
    }

    /**
     * @param float $cur_balance
     *
     * @return bool
     */
    public function set_cur_balance(float $cur_balance)
    {
        $this->cur_balance = $cur_balance;
        return $this->save('cur_balance', $cur_balance);
    }

    /**
     * @return int
     */
    public function get_info(): int
    {
        return $this->info;
    }

    /**
     * @param int $info
     *
     * @return bool
     */
    public function set_info(int $info)
    {
        $this->info = $info;
        return $this->save('info', $info);
    }


    /**
     * @return string
     */
    public function get_time_created(): string
    {
        return $this->time_created;
    }

    /**
     * @param string $time_created
     *
     * @return bool
     */
    public function set_time_created(string $time_created)
    {
        $this->time_created = $time_created;
        return $this->save('time_created', $time_created);
    }

    /**
     * @return string
     */
    public function get_time_updated(): string
    {
        return $this->time_updated;
    }

    /**
     * @param string $time_updated
     *
     * @return bool
     */
    public function set_time_updated(string $time_updated)
    {
        $this->time_updated = $time_updated;
        return $this->save('time_updated', $time_updated);
    }
}