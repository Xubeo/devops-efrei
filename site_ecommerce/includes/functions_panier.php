<?php

function creationPanier(){

   try{

      $db = new PDO('mysql:host=127.0.0.1;dbname=site_ecommerce', 'root','');
      $db->setAttribute(PDO::ATTR_CASE, PDO::CASE_LOWER); // les noms de champs seront en caractères minuscules
      $db->setAttribute(PDO::ATTR_ERRMODE , PDO::ERRMODE_EXCEPTION); // les erreurs lanceront des exceptions
      $db->exec('SET NAMES utf8');           
   }

   catch(Exception $e){

      die('Veuillez vérifier la connexion à la base de données');

   }

   if (!isset($_SESSION['panier'])){
      $_SESSION['panier']=array();
      $_SESSION['panier']['libelleProduit'] = array();
      $_SESSION['panier']['slugProduit'] = array();
      $_SESSION['panier']['qteProduit'] = array();
      $_SESSION['panier']['prixProduit'] = array();
      $_SESSION['panier']['verrou'] = false;
      $data = $select->fetch(PDO::FETCH_OBJ);
   }
   return true;
}

function ajouterArticle($slugProduit,$qteProduit,$prixProduit){

   try{

      $db = new PDO('mysql:host=127.0.0.1;dbname=site_ecommerce', 'root','');
      $db->setAttribute(PDO::ATTR_CASE, PDO::CASE_LOWER); // les noms de champs seront en caractères minuscules
      $db->setAttribute(PDO::ATTR_ERRMODE , PDO::ERRMODE_EXCEPTION); // les erreurs lanceront des exceptions
      $db->exec('SET NAMES utf8');            
   }

   catch(Exception $e){

      die('Veuillez vérifier la connexion à la base de données');

   }

   if (creationPanier() && !isVerrouille())
   {

      $s = $db->query("SELECT title FROM products WHERE slug = '$slugProduit'");
      $r = $s->fetch(PDO::FETCH_OBJ);
      $libelleProduit = $r->title;

      $positionProduit = array_search($slugProduit,  $_SESSION['panier']['slugProduit']);

      if ($positionProduit !== false)
      {
         $_SESSION['panier']['qteProduit'][$positionProduit] += $qteProduit ;
      }
      else
      {  
         array_push( $_SESSION['panier']['libelleProduit'],$libelleProduit);
         array_push( $_SESSION['panier']['slugProduit'],$slugProduit);
         array_push( $_SESSION['panier']['qteProduit'],$qteProduit);
         array_push( $_SESSION['panier']['prixProduit'],$prixProduit);
      }
   }
   else{
   echo "Un problème est survenu veuillez contacter l'administrateur du site.";
   }
}

function modifierQTeArticle($slugProduit,$qteProduit){
   //Si le panier éxiste
   if (creationPanier() && !isVerrouille())
   {
      //Si la quantité est positive on modifie sinon on supprime l'article
      if ($qteProduit > 0)
      {
         //Recharche du produit dans le panier
         $positionProduit = array_search($slugProduit,  $_SESSION['panier']['slugProduit']);

         if ($positionProduit !== false)
         {
            $_SESSION['panier']['qteProduit'][$positionProduit] = $qteProduit ;
         }
      }
      else{
      supprimerArticle($slugProduit);
      }
   }
   else{
   echo "Un problème est survenu veuillez contacter l'administrateur du site.";
   }
}

function supprimerArticle($slugProduit){
   $deleted = 0;

   if (creationPanier() && !isVerrouille())
   {
      for($i = 0; $i < count($_SESSION['panier']['slugProduit']); $i++)
      {
         if ($_SESSION['panier']['slugProduit'][$i] == $slugProduit)
         {
            $deleted = $i;
            unset( $_SESSION['panier']['libelleProduit'][$i]);
            unset( $_SESSION['panier']['slugProduit'][$i]);
            unset( $_SESSION['panier']['qteProduit'][$i]);
            unset( $_SESSION['panier']['prixProduit'][$i]);
         }

      }

      // Lorsque l'on supprime un article du panier, il faut faire "remonter" tous ceux qui viennent après,
      // De cette manière, on évite les "trous" dans la variable SESSION

      foreach ($_SESSION['panier']['slugProduit'] as $key => $value){
            if($key > $deleted){
               $_SESSION['panier']['slugProduit'][$key-1] = $_SESSION['panier']['slugProduit'][$key];
               $_SESSION['panier']['libelleProduit'][$key-1] = $_SESSION['panier']['libelleProduit'][$key];
               $_SESSION['panier']['qteProduit'][$key-1] = $_SESSION['panier']['qteProduit'][$key];
               $_SESSION['panier']['prixProduit'][$key-1] = $_SESSION['panier']['prixProduit'][$key];
               unset($_SESSION['panier']['slugProduit'][$key]);
               unset($_SESSION['panier']['libelleProduit'][$key]);
               unset($_SESSION['panier']['qteProduit'][$key]);
               unset($_SESSION['panier']['prixProduit'][$key]);
            }
      }

   }else{
         echo "Un problème est survenu veuillez contacter l'administrateur du site.";
   }
}

function MontantGlobal(){
   $total=0;
   for($i = 0; $i < count($_SESSION['panier']['slugProduit']); $i++)
   {
      $total += $_SESSION['panier']['qteProduit'][$i] * $_SESSION['panier']['prixProduit'][$i];
   }
   return $total;
}

function supprimerPanier(){
   unset($_SESSION['panier']);
}

function isVerrouille(){
   if (isset($_SESSION['panier']) && $_SESSION['panier']['verrou']){
   return true;
   }else{
   return false;
   }  
}

function compterArticles()
{
   if (isset($_SESSION['panier'])){
   return count($_SESSION['panier']['slugProduit']);
   }else{
   return 0;
   }

}

function CalculFraisPorts(){

   try{

      $db = new PDO('mysql:host=127.0.0.1;dbname=site_ecommerce', 'root','');
      $db->setAttribute(PDO::ATTR_CASE, PDO::CASE_LOWER); // les noms de champs seront en caractères minuscules
      $db->setAttribute(PDO::ATTR_ERRMODE , PDO::ERRMODE_EXCEPTION); // les erreurs lanceront des exceptions
      $db->exec('SET NAMES utf8');            
   }

   catch(Exception $e){

      die('Veuillez vérifier la connexion à la base de données');

   }

   $weight_product = 0;
   $shipping = 0;

   for($i = 0; $i < compterArticles(); $i++){

      for($j = 0; $j < $_SESSION['panier']['qteProduit'][$i]; $j++){

         $slug = addslashes($_SESSION['panier']['slugProduit'][$i]);
         $select = $db->query("SELECT weight FROM products WHERE slug='$slug'");
         $result = $select->fetch(PDO::FETCH_OBJ);
         $weight = $result->weight;

         $weight_product += $weight;

      }

   }

   $select2 = $db->query("SELECT * FROM weights WHERE name <= '$weight_product' ORDER BY price DESC");
   
   $result2 = $select2->fetch(PDO::FETCH_OBJ);

   $shipping = $result2->price;   

   return $shipping;

}

?>