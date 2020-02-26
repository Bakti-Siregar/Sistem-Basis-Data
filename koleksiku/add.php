<html>
     <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Tambah buku baru</title>
         <link href="style.css" type="text/css" rel="stylesheet">
     </head>
     <body>
         <form action="insert_koleksi.php" method="POST">
             <font face="Tahoma" color="green" size="1"><b><br>Masukkan buku baru</b></font>
             <table align="left">
                 <tr>
                     <td><font face="Tahoma" color="black" size="2">judul</font></td>
                     <td>:</td>
                     <td><input type="text" name="judul" size="30"></td>
                 </tr> 
 
                 <tr>
                     <td><font face="Tahoma" color="black" size="2">penulis</font></td>
                     <td>:</td>
                     <td><input type="text" name="penulis" size="30"></td>
                 </tr> 
 
                 <tr>
                     <td></td><td></td>
                     <td><input type="submit" value="Add">
                     <font face="Tahoma" color="green" size="2">
                     <a href="index.php" style="text-decoration:none">back</font></a>
                     </td>
                 </tr>
             </table>
         </form>
     </body>
 </html>