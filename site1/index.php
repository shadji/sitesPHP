<html>
 <head>
   <title>PHP Test</title>
    </head>
     <body>
      <?php echo '<p>Test site 1</p>'; ?>
	   <img src="./images/site.jpg" alt="site"/>
		<form action="upload.php" method="post" enctype="multipart/form-data">
			Select image to upload:
			<input type="file" name="fileToUpload" id="fileToUpload">
			<input type="submit" value="Upload Image" name="submit">
		</form>
     </body>
</html>
