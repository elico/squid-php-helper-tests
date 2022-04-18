#!/usr/bin/env php

<?php
$redis = new Redis();
$redis->connect('127.0.0.1', 6379);

$temp = array();

$login_time = 30*60;

while ( $input = readline() ) {
	$current_time = new DateTime("now");
	
	$temp = explode(' ', $input);
	$answer = "ERR";
	if (isset($temp[1])) {
		$ip_login_time = $redis->get($temp[1]);
		if ($ip_login_time !== false) {
			$ip_login_time = new DateTime('@' . $ip_login_time);
		
			$ip_login_time = intval($ip_login_time->format('U'));
			$diff = $current_time->format('U') - $ip_login_time;
			if ( $diff > $login_time ) {
				$answer = "ERR";
			} else {
				$answer = "OK";
			}
		} else {
			$answer = "ERR";
		}

	}
	
	if (isset($temp[2])) {
		switch ($temp[2]) {
		case "LOGIN":
			$now = new DateTime("now");
			$ip_login_time = $redis->set($temp[1], $now->format('U'));
			$answer = "OK message=\"Welcome\"";
	        	break;
		case "LOGOUT":
			$redis->delete($temp[1]);
			$answer = "OK message=\"ByeBye\"";
		        break;
		case "QUIT":
			exit;
			break;
		}
	}
	$output = $temp[0] . " " . $answer;
	echo $output."\n";
}
?>
