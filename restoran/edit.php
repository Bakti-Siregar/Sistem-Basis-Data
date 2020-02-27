<?php 
include "db_connect.php"; 
$id = $_GET['id']; 
 
$query=mysqli_query($kon, "SELECT * FROM bulanan WHERE id='$id'");
while ($row=mysqli_fetch_array($query)){ 
 
$bulan = $row['bulan']; 
$biayaiklan = $row['biayaiklan']; 
$pengeluaran = $row['pengeluaran']; 
$pendapatan = $row['pendapatan'];
echo "<html>"; 
echo "<body>"; 
echo "<font face='tahoma' color='green' size=4><b>Perbaiki data</b></font>"; 
echo "<table align='left'>"; 
echo "<form method=\"post\" action=\"update.php?id=$id\" enctype='multipart/form-data'>"; 
echo "<br>"; 
echo "<tr><td><font face='Tahoma' color='black' size=2>bulan </font></td><td>:</td><td><input type='text' name='bulan' value='$bulan' size='30'>&nbsp;
</td></tr>"; 
 
echo "<tr><td><font face='Tahoma' color='black' size=2>biayaiklan</font></td><td>:</td><td><input type='text' name='biayaiklan' value='$biayaiklan' size='30'>&nbsp;
</td></tr>"; 
 
echo "<tr><td><font face='Tahoma' color='black' size=2>pengeluaran </font></td><td>:</td><td><input type='text' name='pengeluaran' value='$pengeluaran' size='30'>&nbsp;
</td></tr>";
echo "<tr><td><font face='Tahoma' color='black' size=2>pendapatan </font></td><td>:</td><td><input type='text' name='pendapatan' value='$pendapatan' size='30'>&nbsp;
</td></tr>";
echo "<tr><td></td><td></td><td><font size='2'><input type='submit' name='submit' value='Update'/></font></td></tr>"; 
echo "</table></form></body></html>"; 
} 
?>