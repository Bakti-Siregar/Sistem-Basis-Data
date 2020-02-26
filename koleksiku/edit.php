<?php 
include "db_connect.php"; 
$id = $_GET['id']; 
 
$query=mysqli_query($kon, "SELECT * FROM tbperpus WHERE id='$id'");
while ($row=mysqli_fetch_array($query)){ 
 
$judul = $row['judul']; 
$penulis = $row['penulis']; 
 
echo "<html>"; 
echo "<body>"; 
echo "<font face='tahoma' color='green' size=4><b>Perbaiki koleksi</b></font>"; 
echo "<table align='left'>"; 
echo "<form method=\"post\" action=\"update.php?id=$id\" enctype='multipart/form-data'>"; 
echo "<br>"; 
echo "<tr><td><font face='Tahoma' color='black' size=2>judul </font></td><td>:</td><td><input type='text' name='judul' value='$judul' size='30'>&nbsp;
</td></tr>"; 
 
echo "<tr><td><font face='Tahoma' color='black' size=2>penulis</font></td><td>:</td><td><input type='text' name='penulis' value='$penulis' size='30'>&nbsp;
</td></tr>"; 
 
echo "<tr><td></td><td></td><td><font size='2'><input type='submit' name='submit' value='Update'/></font></td></tr>"; 
echo "</table></form></body></html>"; 
} 
?>