<?php

require_once('includes/route/routeManager.php');
$manager = new routeManager();
$manager->getRoute($_GET['url']);