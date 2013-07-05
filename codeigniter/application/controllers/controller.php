<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Controller extends CI_Controller {

/**
 * The index() function gets called automatically when running this 
 * example. It will perform the following steps:
 * 
 *    1) Connect to a mySQL database (see /application/config/database.php)
 *    2) Load a database model (see /application/models/simple_model.php)
 *    3) Create a table named 'items' if it doesn't already exist
 *    4) Insert an item to the 'items's table
 *    5) Retrieve and print the last inserted item
 *    6) Retrieves and prints the row count of the 'items' table
 *
 * The Terminal (adjacent to the Console Output) can be used to connect
 * directly to the mySQL database. Just type in 'mysql' to connect.
 * 
 */


  public function index()
  {
   
    /* Connect to the mySQL database - config values can be found at:
      /application/config/database.php */
    $dbconnect = $this->load->database();


    /* Load the database model:
      /application/models/simple_model.php */
    $this->load->model('Simple_model');
    

    /* Create a table if it doesn't exist already */
    $this->Simple_model->create_table();
    
    
    /* Call the "insert_item" entry */
    $this->Simple_model->insert_item('Hello from Runnable!');

    /* Retrieve the last item  */
    print '<pre>';
    print_r($this->Simple_model->get_last_item());
    print '</pre>';

    /* Retrieve and print the row count */
    $rowcount = $this->Simple_model->get_row_count();
    print '<strong>Row count: ' . $rowcount . '</strong>';
    }
    
}

/* End of file controller.php */
/* Location: ./application/controllers/controller.php */