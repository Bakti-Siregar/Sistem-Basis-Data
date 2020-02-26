<?php 
include "db_connect.php"; 
$query=mysqli_query ($kon, "SELECT * FROM tbperpus")or die (mysqli_error()); 
$jumlah = mysqli_num_rows($query); 
echo "<html>"; 
echo "<head>"; 
echo "<link href='style.css' type='text/css' rel='stylesheet'>"; 
echo "</head>"; 
echo "<title>Perpustakaan Kecil</title>"; 
echo "<body>"; 
echo "<font color='darkmagenta' face='Arial' size=3><b><br>Koleksi Bukuku</b></font><br><br>"; 
echo "<a href='add.php' style=\"text-decoration: none\"><font face='tahoma' size='1'>Masukkan buku baru</font></a><br>"; 
echo "<br><table  border=\"0\" cellpadding=\"1\" cellspacing=\"1\" bordercolor=\"blue\" bgcolor=\"white\"> 
<tr bgcolor='blue' height=\"30\"><font color='white'>  
     <th align='center'><font color='white' face='Arial' size=2>No</font></th>         
     <th align='center'><font color='white' face='Arial' size=2>Judul</font></th>         
     <th align='center'><font color='white' face='Arial' size=2>Penulis</font></th>         
     <th align='center'><font color='yellow' face='Arial' size=2>Ubah?</font></th> 
</tr>";  
$j=0; 
while ($row=mysqli_fetch_array($query)) {     
    echo "<tr><td align='left' bgcolor='#657FFF'>";
    echo "<font face='Arial' size=1>";
    echo $j+1;
    echo"</font>";
    echo"</td>";     
    echo "<td align='left' bgcolor='#E8D3DF'>";
    echo "<font face='Arial' size=1>";
    echo $row["judul"];
    echo"</font>";
    echo"</td>";  
    echo "<td align='left' bgcolor='#E8D3DF'>";
    echo "<font face='Arial' size=1>";
    echo $row["penulis"];
    echo"</font>";
    echo"</td>";     
    echo"<td align='left' bgcolor='#E8D3DF'>";
    echo "<a href='delete.php?id=".$row['id']."' style=\"text-decoration: none\" title=\"Hapus\"><font face='tahoma' size='1'>Hapus</font></a>   
    <a href='edit.php?id=".$row['id']."' style=\"text-decoration: none\" title=\"Edit\"><font face='tahoma' size='1'>Edit</font></a>"; $j++; } 
echo"</table>"; 
echo "</body>"; 
echo "</html>"; 
?>