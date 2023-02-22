<?php

	session_start();

	try{

		$bdd = new PDO('mysql:host=127.0.0.1;dbname=site_ecommerce', 'root','');
		$bdd->setAttribute(PDO::ATTR_CASE, PDO::CASE_LOWER); // les noms de champs seront en caractères minuscules
		$bdd->setAttribute(PDO::ATTR_ERRMODE , PDO::ERRMODE_EXCEPTION); // les erreurs lanceront des exceptions
		$bdd->exec('SET NAMES utf8');				
	}

	catch(Exception $e){

		die('Erreur : '.$e->getMessage());

	}

?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf8">
		<link href="style/bootstrap.css" type="text/css" rel="stylesheet"/>
	</head>
	<header>
		<br/><h1>Site E-Commerce</h1><br/>
		<ul class="menu">
			<li><a href="index.php">Accueil</a></li>
			<li><a href="boutique.php">Boutique</a></li>
			<li><a href="panier.php">Panier</a></li>
			<?php if(!isset($_SESSION['user_id'])){?>
			<li><a href="register.php">S'inscrire</a></li>
			<li><a href="connect.php">Se connecter</a></li>
			<?php }else{ ?>
			<li><a href="my_account.php">Mon compte</a></li>
			<?php } ?>
		</ul>
		<p>Bienvenue sur notre boutique d'électronique, ici vous pourrez acheter des composants électroniques ainsi que des ordinateurs. Tout d'abord veuillez vous connecter.</p>
	</header>
