<?php
	class Database
	{
		private $host = "teamgamma.ga";
		private $user = "teamgamma_ga";
		private $pass = "KnEdBAr0vH2";
		private $connection;
		function __construct()
		{
			$connection = new mysqli($host, $user, $pass);
			if($connection->connect_error)
				die("Connection failure: " . $connection->connect_error);
			else
			{
				$connection->select_db("teamgamma_sharingapi");
				echo "Connection successful";
			}
		}
		function __destruct()
		{
			$connection->close();
		}
		public function viewTable()
		{
			$query = "show * from Mockdata";
			$results = $connection->query($query);
			if($results->num_rows > 0)
			{
				while($row = $result->fetch_assoc())
				{
					echo $row["id"].",".$row["name"].$row["author"].$row["dateCreated"].$row["imageURL"].$row["ratings"].$row["dateUploaded"]."<br>";
				}
			}
			else
				echo "Unsuccessful";
		}
	}
	$db = new Database();
	$db->viewTable();
?>
