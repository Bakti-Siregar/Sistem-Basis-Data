<?php 
include "db_connect.php"; 
$judul = $_POST['judul'];
$penulis = $_POST['penulis']; 
 
$query=mysqli_query($kon, "INSERT INTO tbperpus(judul, penulis)
VALUES ('$judul', '$penulis')")or die (mysqli_error()); 
 
if($query) {
?>
<script language="JavaScript">
   document.location='index.php'</script> 
<?php 
} 
?>