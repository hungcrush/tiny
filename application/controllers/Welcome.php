<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Welcome extends TINY_Controller {
    
    public function __construct(){
        parent::__construct();
        $this->load->model('content_model', 'content');
    }
    
	public function index(){
	    $data = $this->content->loadContentIndex();
        unset($data['data']['path']);
		$this->data = array(
            'template'  => 'templates/indexPage.htm',
            'dataParse' => $data['data']
        );
	}
    
    //-- function load Template for angular
    public function Load(){
        if(isset($_GET['template'])){
            $this->data = array('template' => $_GET['template']);
        }else{
            show_error('Found not file.');
        }
    }
    
    public function Delete(){
        if(!isset($_GET['path'])) return false;
        switch($_GET['path']){
            case 'uploads':
                if(isset($_POST['folder']) && isset($_POST['filename'])){
                    @unlink('uploads/'.$_POST['folder'].'/full-size/'.$_POST['filename']);
                    @unlink('uploads/'.$_POST['folder'].'/thumbs/'.$_POST['filename']);
                }
                break;
        }
    }
         
    
}
