<?php 
include "db_connect.php"; 
$id = $_GET['id']; 
 
$judul = $_POST['judul']; 
$penulis = $_POST['penulis']; 
 
$query=mysqli_query ($kon, "UPDATE tbperpus SET judul='$judul', 
penulis='$penulis' WHERE id='$id'")or die (mysqli_error()); 
 
if($query) { 
?>
<script language="JavaScript"> 
 document.location='index.php'</script> 
<?php 
} 
?>