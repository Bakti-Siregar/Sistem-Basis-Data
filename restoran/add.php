?
<html>
     <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Tambah data baru</title>
         <!-- <link href="style.css" type="text/css" rel="stylesheet"> -->
     </head>
     <body>
         <form action="insert_data.php" method="POST">
             <font face="Tahoma" color="green" size="1"><b><br>Masukkan data baru</b></font>
             <table align="left">
                 <tr>
                     <td><font face="Tahoma" color="black" size="2">bulan</font></td>
                     <td>:</td>
                     <td><input type="text" name="bulan" size="30"></td>
                 </tr> 
 
                 <tr>
                     <td><font face="Tahoma" color="black" size="2">biayaiklan</font></td>
                     <td>:</td>
                     <td><input type="text" name="biayaiklan" size="30"></td>
                 </tr> 
 
     <tr>
                     <td><font face="Tahoma" color="black" size="2">pengeluaran</font></td>
                     <td>:</td>
                     <td><input type="text" name="pengeluaran" size="30"></td>
                 </tr>
     
     <tr>
                     <td><font face="Tahoma" color="black" size="2">pendapatan</font></td>
                     <td>:</td>
                     <td><input type="text" name="pendapatan" size="30"></td>
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