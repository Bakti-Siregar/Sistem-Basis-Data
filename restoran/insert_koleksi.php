<?php 
include "db_connect.php"; 
$bulan = $_POST['bulan'];
$biayaiklan = $_POST['biayaiklan']; 
$pengeluaran = $_POST['pengeluaran'];
$pendapatan = $_POST['pendapatan'];
 
$query=mysqli_query($kon, "INSERT INTO bulanan(bulan,biayaiklan,pengeluaran,pendapatan)
VALUES ('$bulan', '$biayaiklan','$pengeluaran','$pendapatan')")or die (mysqli_error()); 
 
if($query) {
?>
<script language="JavaScript">
   document.location='index.php'</script> 
<?php 
} 
?>