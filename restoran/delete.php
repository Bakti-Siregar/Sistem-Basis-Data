<?php 
include "db_connect.php"; 
$id = $_GET['id']; 
 
$query = "DELETE FROM bulanan WHERE id = $id"; 
mysqli_query($kon, $query); 
 
?> 
<script language="JavaScript"> 
document.location='index.php'</script> 
<?php 
?>