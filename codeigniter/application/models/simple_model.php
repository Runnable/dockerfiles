<?php

class Simple_model extends CI_Model {
  
  
  function __construct() 
  {
    /* Call the Model constructor */
    parent::__construct();
  }


  function get_last_item()
  {
    $this->db->order_by('id', 'DESC');
    $query = $this->db->get('items', 1);
    
    return $query->result();
  }
  
  
  function insert_item($item)
  {
    $this->item = $item;
    
    $this->db->insert('items', $this);
  }


  function get_row_count()
  {
    return $this->db->count_all('items');
  }


  function create_table()
  { 
    /* Load db_forge - used to create databases and tables */
    $this->load->dbforge();
    
    
    /* Specify the table schema */
    $fields = array(
                    'id' => array(
                                  'type' => 'INT',
                                  'constraint' => 5,
                                  'unsigned' => TRUE,
                                  'auto_increment' => TRUE
                              ),
                    'item' => array(
                                  'type' => 'VARCHAR',
                                  'constraint' => '100'
                              ),
                    'date TIMESTAMP DEFAULT CURRENT_TIMESTAMP'
              );
    
    /* Add the field before creating the table */
    $this->dbforge->add_field($fields);
    
    
    /* Specify the primary key to the 'id' field */
    $this->dbforge->add_key('id', TRUE);
    
    
    /* Create the table (if it doesn't already exist) */
    $this->dbforge->create_table('items', TRUE);
    
  }


}