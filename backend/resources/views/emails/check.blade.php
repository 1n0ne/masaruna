<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        /*verfication_email*/
        #verfication_email .main h1 {
            letter-spacing: 0;
        }

        #verfication_email .main a {
            color: #112d77;
        }

        /*verfication_email*/
        #verfication_email .main h1 {
            letter-spacing: 0;
        }

        #verfication_email .main a {
            color: #112d77;
        }

        .container {
            width: 100%;
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
        }

        .def_btn {
            border-radius: 5px;
            padding: 10px 30px;
            border: 2px solid #112d77;
            letter-spacing: 1px;
        }

        .main button {
            min-width: 555px;
            cursor: pointer;
            -webkit-box-shadow: 0px 6px 15px rgba(15, 43, 118, 0.3);
            box-shadow: 0px 6px 15px rgba(15, 43, 118, 0.3);
            position: relative;
            margin-top: 20px;
            border-radius: 5px;
            padding: 10px 30px;
            border: 2px solid #112d77;
            letter-spacing: 1px;
            background-color: #112d77;
            color: white;
        }

    </style>
</head>
<body id="verfication_email" class="inner" style="text-align:center;">

<!-- main -->
<div class="main">
    <div class="container">
        <h1>your password</h1>
        <div>
            <h3 style="color:blue;">{{$password}}</h3>
        </div>
    </div>
</div>

</body>
</html>
