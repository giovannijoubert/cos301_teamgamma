<?php
	//This program uses the Composer program 
	//along with PHPUnit and Guzzle all installed using Ubuntu
	//to test upload requests to the API.
	//Note that the request will not go through if requestType is not provided.
	require('vendor/autoload.php');

	class APITest extends PHPUnit_Framework_TestCase
	{
		protected $client;
		
		public function testPostUpload()
		{
			$base64Image = "data:image/png;base64,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";
			$client = new \GuzzleHttp\Client();
			$response = $client->request('POST', 'http://teamgamma.ga/api/sharingapi.php', ['json' => 
				[
					'requestType' => 'upload',
					'title' => 'UploadUnitTest',
					'category'=> 'UnitTest',
					'description'=> 'Uploading two images to test the APIs upload functionality.',
					'mouthImages'=>
					[
						[
							'formantLetters'=> 'aei',
							'imageData'=> $base64Image							
						],
						[
							'formantLetters'=> 'ghf',
							'imageData'=> $base64Image
						]
					]
				]			
			]);
			$this->assertEquals(200, $response->getStatusCode());
			//Note that the API will still accept upload requests if no data is provided for: title, category, description and mouthImages.
		}
		
		public function testPostDownload()
		{
			$client = new \GuzzleHttp\Client();
			
			$response = $client->request('POST', 'http://teamgamma.ga/api/sharingapi.php', ['json' => 
				[
					'requestType' => 'getAllMouthpacks'
				]			
			]);
			$this->assertEquals(200, $response->getStatusCode());
			//uncomment to view result
			//echo $response->getBody();
			
			$response = $client->request('POST', 'http://teamgamma.ga/api/sharingapi.php', ['json' => 
				[
					'requestType' => 'getAllMouthpacks',
					'filter'=>
					[
						'criteria'=> 'mouthpack_name',
						'like'=> 'UploadUnitTest'							
					],
					'sort_by' => 'mouthpack_id',
					'order' => 'desc'
				]			
			]);
			$this->assertEquals(200, $response->getStatusCode());
			//uncomment to view result			
			//echo $response->getBody();
		}
	}
?>
