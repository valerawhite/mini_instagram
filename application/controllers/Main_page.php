<?php

use Model\Login_model;
use Model\Post_model;
use Model\User_model;
use Model\Boosterpack_model;
/**
 * Created by PhpStorm.
 * User: mr.incognito
 * Date: 10.11.2018
 * Time: 21:36
 */
class Main_page extends MY_Controller
{

    public function __construct()
    {
        parent::__construct();

        if (is_prod())
        {
            die('In production it will be hard to debug! Run as development environment!');
        }
    }

    public function index()
    {
        $user = User_model::get_user();
        
        App::get_ci()->load->view('main_page', ['user' => User_model::preparation($user, 'default')]);

    }

    public function get_all_posts()
    {
        $posts =  Post_model::preparation(Post_model::get_all(), 'main_page');
        return $this->response_success(['posts' => $posts]);
    }

    public function get_post($post_id){ // or can be $this->input->post('news_id') , but better for GET REQUEST USE THIS

        $post_id = intval($post_id);

        if (empty($post_id)){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        try
        {
            $post = new Post_model($post_id);
        } catch (EmeraldModelNoDataException $ex){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }


        $posts =  Post_model::preparation($post, 'full_info');
        return $this->response_success(['post' => $posts]);
    }


    public function comment(){ // or can be App::get_ci()->input->post('news_id') , but better for GET REQUEST USE THIS ( tests )
        $data = json_decode(App::get_ci()->input->raw_input_stream);
        $post_id = $data->post_id;
        $message = $data->text;
        
        if (!User_model::is_logged()){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }
        if($data->scrf !== App::get_ci()->session->userdata('scrf'))
            return $this->response_error('Fatal Error: Not a valid token scrf');

        $post_id = intval($post_id);

        if (empty($post_id) || empty($message)){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        try
        {
            $post = new Post_model($post_id);
        } catch (EmeraldModelNoDataException $ex){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }

        // Todo: 2 nd task Comment
        $post->comment($post_id, $message);

        $posts =  Post_model::preparation($post, 'full_info');
        return $this->response_success(['post' => $posts]);
    }


    public function login()
    {
        // Right now for tests we use from contriller
        //$login = App::get_ci()->input->post('login');
        //$password = App::get_ci()->input->post('password');
        $data = json_decode(App::get_ci()->input->raw_input_stream);
        $login = $data->login;
        $password = $data->password;
        
     
        if (empty($login) || empty($password)){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }
        // But data from modal window sent by POST request.  App::get_ci()->input...  to get it.
        //Todo: 1 st task - Authorisation.
        $user_id = User_model::get_user_id($login, $password);
        try
        {
            if($user_id)
               $user = new User_model($user_id);
        } catch (EmeraldModelNoDataException $ex){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }
        Login_model::start_session($user);

        return $this->response_success(['user' => User_model::preparation($user, 'default')]);
    }


    public function logout()
    {
    
        Login_model::logout();
        redirect(site_url('/'));
    }

    public function add_money(){
        // todo: 4th task  add money to user logic
        if (!User_model::is_logged()){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }
        $data = json_decode(App::get_ci()->input->raw_input_stream);
        $sum = floatval($data->sum);

        if($data->scrf !== App::get_ci()->session->userdata('scrf'))
            return $this->response_error('Fatal Error: Not a valid token scrf');
        if (!is_float($sum)){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }
       
        try {
          $user = new User_model(User_model::get_session_id());
          $user->preparetion_balance_for_update($sum, true);
            try {
                $user->update(['wallet_balance'=> $current_balance, ' wallet_total_refilled' => $current_total_balance]);
            } catch(Exception $ex) {
                return $this->response_error('error of transuction update');
            }
          
        } catch(EmeraldModelNoDataException $ex) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }
        return $this->response_success(['amount' => $current_balance]);
    }

    public function buy_boosterpack(){
        // todo: 5th task add money to user logic
        if (!User_model::is_logged()){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $busterpacs = [1 => 5, 2 => 20, 3 => 50];
        $data = json_decode(App::get_ci()->input->raw_input_stream);
        if(array_key_exists($data->id, $busterpacs)) {
            $user = new User_model(User_model::get_session_id());
            $current_balance = $user->get_wallet_balance();

            if($current_balance > $busterpacs[$data->id]) {
                $boost = new Boosterpack_model($data->id);
            } else {
                return $this->response_error('not enough money');
            }

        } else {
            return $this->response_error('not found id package');
        }
        return $this->response_success(['amount' => $boost->get_random_likes($busterpacs[$data->id], $user)]); // Колво лайков под постом \ комментарием чтобы обновить . Сейчас рандомная заглушка
    }


    public function like(){
        // todo: 3rd task add like post\comment logic
        if (!User_model::is_logged()){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $post_id = App::get_ci()->input->get('post_id');

        $user = new User_model(User_model::get_session_id());
        $current_count_likes = $user->get_wallet_total_likes();
        
        if($current_count_likes > 0) {
            $current_count_likes--;
            $user->update(['wallet_total_likes'=> $current_count_likes]);

            $post_id = intval($post_id);
            if (empty($post_id)){
                return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
            }
            
            try
           {
               $post = new Post_model($post_id);
           } catch (EmeraldModelNoDataException $ex){
               return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
           }
            $current_likes_post = $post->get_likes();
            $current_likes_post++;
            $post->update(['likes'=> $current_likes_post]);
        } else {
         throw new Exception('Нет денег - нет лайков');
        }
        return $this->response_success(['likes' => $current_likes_post]);
    }

}
