<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Thêm học sinh</title>
</head>

<body>
<?php
	$servername = "localhost"; //Tên server
	$username = "root";//Tên user name để truy cập vào database
	$password = "";//Mật khẩu của user name dòng 11
	$dbname = "quanlihs";// tên database mà $username đc phép truy cập làm việc. Một $username có thể truy cập đc nhiều databse. Chỉ những username nào đc cấp quyền vào datatabase nào thì mới truy cập đc vào db đó.

	

	//$name = $class = $diachi = $dienthoai = $email =""; KHÔNG CẦN KHAI BÁO

	if ($_SERVER["REQUEST_METHOD"] == "POST") { // Nếu phát hiện có form SUBMIT method POST (dòng 52) thì làm những việc sau
		$name = get_data_form($_POST["txtName"]);// Gán dữ liệu của txtName vào $name
		$class = get_data_form($_POST["txtClass"]);//tương tự dòng 20
		$diachi = get_data_form($_POST["txtDiachi"]);//tương tự dòng 20
		$dienthoai = get_data_form($_POST["txtSDT"]);//tương tự dòng 20
		$email = get_data_form($_POST["txtEmail"]);//tương tự dòng 20
		
		
		$conn = new mysqli($servername, $username, $password, $dbname); //Kết nối đến cơ sở dữ liệu (CSDL)
		
		$sql = "insert into danhsachhocsinh(hoten,lop,diachi,dienthoai,email) values ('$name','$class','$diachi','$dienthoai','$email')"; //Viết câu lệnh thực thi để insert dữ liệu vào database (ứng dụng SQL server đã học).
		
		if ($conn->query($sql) === TRUE) { //Nếu thực thi Insert thành công thì....
		  echo "Cập nhật thành công"; //thì echo ra câu này
		} else {//ngược lại
		  echo "Error: " . $sql . "<br>" . $conn->error; //Echo ra lỗi kèm theo mã lỗi.
		}
		
		mysqli_close($conn); //Ngắt kết nối đến database.
		
	}

	//function để lọc dữ liệu khi người dùng nhập vào form,
	function get_data_form($data) {
	  $data = trim($data);// loại bỏ các ký tự KHOẢNG TRẮNG 2 đầu chuỗi
	  $data = stripslashes($data); // Ý nghía: -> google
	  $data = htmlspecialchars($data); //ý nghĩa -> tự search
	  return $data; //Sau khi lọc đc dữ liệu, -> trả về chuỗi giá trị mà người dùng nhạp
	}

	
	


?>
<form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post">
	<p>Tên: <input type="text" name="txtName" placeholder="YourName"/></p>
	<p>Lớp: <input type="text" name="txtClass" placeholder="YourClass" /></p>
	<p>Địa chỉ: <input type="text" name="txtDiachi" placeholder="Diachi" /></p>
	<p>SĐT: <input type="text" name="txtSDT" placeholder="sdt"/></p>
	<p>Email: <input type="text" name="txtEmail" placeholder="Email" /></p>
	<input type="submit" name="txtSubmit" value="SUBMIT" />
</form>

</body>
</html>