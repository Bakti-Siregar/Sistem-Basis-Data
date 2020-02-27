<?php 
include "db_connect.php"; 
$id = $_GET['id']; 
 
$bulan = $_POST['bulan']; 
$biayaiklan = $_POST['biayaiklan']; 
$pengeluaran = $_POST['pengeluaran'];
$pendapatan = $_POST['pendapatan'];
 
$query=mysqli_query ($kon, "UPDATE bulanan SET bulan='$bulan', 
biayaiklan='$biayaiklan', pengeluaran='$pengeluaran', 
pendapatan ='$pendapatan'  WHERE id='$id'")or die (mysqli_error()); 
 
if($query) { 
?>
<script language="JavaScript"> 
 document.location='index.php'</script> 
<?php 
} 
?>