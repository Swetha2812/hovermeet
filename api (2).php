<?php

require_once("base.php");
include("class.php");

$input = json_decode(file_get_contents("php://input"));
$apiKey = "12341234";

if($input->apiKey != $apiKey){
    echo json_encode(
        array(
            "status" => "400",
            "message" => "Invalid API Key"
        ));
    exit;
}


$name = $input->functionName;
$param = $input->param;
switch($name){
    case "login_user":
        login_user($conn,$param);
        break;
    case "register_user":
        register_user($conn,$param);
        break;
    case "otp_verify":
        otp_verify($conn,$param);
        break;
    case "forgot_password":
        forgot_password($conn,$param);
        break;
    case "changepass":
        changepass($conn,$param);
        break;
    case "add_catagory":
        add_catagory($conn,$param);
        break;
    case "category":
        category($conn,$param);
        break;
    case "own_class":
        own_class($conn,$param);
        break;
    case "own_class1":
        own_class1($conn,$param);
        break;
    case "add_live_class":
        add_live_class($conn,$param);
        break;
    case "add_live_class1":
        add_live_class1($conn,$param);
        break;
    case "get_all_classes":
        get_all_classes($conn,$param);
        break;
    case "teacher_update":
        teacher_update($conn,$param);
        break;
    case "get_all_classes_teacher":
        get_all_classes_teacher($conn,$param);
        break;
    case "student_enrollment":
        student_enrollment($conn,$param);
        break;
    case "classdetails":
        classdetails($conn,$param);
        break;
    case "enroll" :
        enroll($conn,$param);
        break;
    case "image_upload":
        image_upload($conn,$param);
        break;
    case "profile":
        profile($conn,$param);
        break;
    case "user_update":
        user_update($conn,$param);
        break;
    case "enrolleddata":
        enrolleddata($conn,$param);
        break;
    // case "push_notification":
    //     push_notification($conn,$param);
    //     break;
    case "start":
        start($conn,$param);
        break;
    case "unenroll":
        unenroll($conn,$param);
        break;
    // case "profile1":
    //     profile1($conn,$param);
    //     break;
    default:
        echo json_encode(
            array(
                "status" => "404",
                "message" => "Function Not Found"
            ));
        break;
}

function push_notification($fcmtoken)
{
    print("start");
    $json_data = [
    "to" => "ezmLPd5LQOObZhnEe49Rfa:APA91bEAnXieZeKqbXEpxIPGLP3F08fvqu2U9zYO_5a2c1RNp1fz5Fubjh9Ab0suwGphrE_ACkiWUrUgBTYUDgH52NrO131FbZty3iiZFwS3WAIuq2_lp5E0RjjroBuFqVCGzkiO2lmY",
    "notification" => [
         "title" => "Hoverminds",
        "body" => "Class will start in 5 minutes "
       
        ]
];
    $data = json_encode($json_data);
//FCM API end-point
$url = 'https://fcm.googleapis.com/fcm/send';
//api_key in Firebase Console -> Project Settings -> CLOUD MESSAGING -> Server key
$server_key = 'AAAAiKUWtrA:APA91bECEzt1l3H3Rr8iw3Sk8u4iAQGuF216gfbEFGI3NymXfJ7Heh7Lj3q4AXk_54DsOVSTLwZnd4ku4jbDfW3ad69Y9i78VGvti7nN9mfnhBs0AZOsEgKhNGJoWe4r0LBgwqbFE1uy';
//header with content_type api key
$headers = array(
    'Content-Type:application/json',
    'Authorization:key='.$server_key
);
//CURL request to route notification to FCM connection server (provided by Google)
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
$result = curl_exec($ch);
if ($result === FALSE) {
    die('Oops! FCM Send Error: ' . curl_error($ch));
}
curl_close($ch);
print($result);
}

function start($conn,$param){

        $sql = "UPDATE liveclass SET isStart = '1' WHERE liveId = ".$param->Id.";";
        
        $isInserted = FALSE;
        try{
            $isInserted = $conn->query($sql);
            if ($isInserted === TRUE) {
                 $sql1 = "SELECT uId,cId FROM enrolledcourse WHERE liveId='".$param->Id."'";
                    $result = $conn->query($sql1);
                    $row = $result->fetch_assoc();
                    // $sql3 = "SELECT categoryName FROM category WHERE cId = '".$row["cId"]."'";
                    // $result3 = $conn->query($sql3);
                    // $row3 = $result3->fetch_assoc();
                   
                    if($result->num_rows>0){
                        while(  $row = $result->fetch_assoc()){
                             echo $row["cId"];
                        $sql2 = "SELECT fcmtoken FROM user WHERE uId='".$row["uId"]."'";
                        $result1 = $conn->query($sql2);
                        if($result1->num_rows>0){
                        while(  $row1 = $result1->fetch_assoc()){
                            echo $fcmtoken;
                            $fcmtoken= $row1["fcmtoken"];
                            push_notification($fcmtoken);
                        }
                        }
                        
                echo json_encode(
                array(
                    "status" => "200",
                    "message" => "Updated"
                ));
            }
            }else {
                echo json_encode(
                    array(
                        "status" => "400",
                        "data" => "Error"
                    ));
            }
        }}catch(Exception $e){
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Already exist"
                ));
        }
}

function otp_verify($conn,$param){
    $email=$param->email;
    $otp=$param->otp;
    $res=[];
    $sql = "SELECT * FROM user_tb WHERE email_Id='".$email."'";
    $result = $conn->query($sql);
    if($result->num_rows>0){
        while(  $row = $result->fetch_assoc()){
            if($row["otp"]===$otp){
                $sql1="UPDATE user_tb SET verify='1' WHERE email_Id='".$email."'";
                $result = $conn->query($sql);
                $res['status']=200;
                $res['message']="OTP verified";
                $res['userInfo']=$row;
                break;
            }else{
                $res['status']=400;
                $res['message']="invalid OTP";
            }
        }
    }
    else
    {
        $res['status']=400;
        $res['message']="Invalid Login Details";
    }
    $json_data=json_encode($res);      
    echo $json_data;
}
function changepass($conn,$param){
    $email=$param->email;
    $pass=$param->pass;
    $res=[];
    $sql = "UPDATE user_tb SET verify='1',password='".$pass."' WHERE email_Id='".$email."'";
    $result = $conn->query($sql);
    if($result===TRUE){
        
                $res['status']=200;
                $res['message']="PASSWORD CHANGED";
                
    }
    else
    {
        $res['status']=400;
        $res['message']="PASSWORD UNCHANGED";
    }
    $json_data=json_encode($res);      
    echo $json_data;
}

function register_user($conn,$param){

    $otp = rand(100000,999999);
    $fcmtoken = $param->fcm;
    $sql = "INSERT INTO user(name,emailId,phone,password,userType,otp,fcmtoken)
    VALUES ('".$param->name."','".$param->email."','".$param->phone."','".$param->password."',".$param->usertype.",'".$otp."','".$fcmtoken."')";
    $isInserted = FALSE;

    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE) {

            $call = new XMLHttpRequest;
            $call->open("POST", "https://hoverminds.com/SendMail/api.php?request=sendHoverMail");
            $call->setRequestHeader("Content-Type","application/json");
            $call->send('{"apiKey" : 11111,
                "email": "'.$param->email.'",
                "your_name" : "Hoverminds",
                "subject": "OTP Varification",
                "name" : "'.$param->name.'",
                "body" : "Please Verify your OTP '.$otp.'"
            }');

            echo json_encode(
            array(
                "status" => "200",
                "message" => "Inserted"
            ));
        } else {
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Error"
                ));
        }
    }catch(Exception $e){
        echo json_encode(
            array(
                "status" => "400",
                "data" => "Already exist"
            ));
    }
}

// function otp_verify($conn,$param){
//     $email=$param->email;
//     $otp=$param->otp;
//     $res=[];
//     $sql = "SELECT * FROM user WHERE emailId='".$email."'";
//     $result = $conn->query($sql);
//     if($result->num_rows>0){
//         while(  $row = $result->fetch_assoc()){
//             if($row["otp"]===$otp){
//                 $res['status']=200;
//                 $res['message']="OTP verified";
//                 $res['userInfo']=$row;
//                 break;
//             }else{
//                 $res['status']=400;
//                 $res['message']="invalid OTP";
//             }
//         }
//     }
//     else
//     {
//         $res['status']=400;
//         $res['message']="Invalid Login Details";
//     }
//     $json_data=json_encode($res);      
//     echo $json_data;
// }

function login_user($conn,$param){
    $email=$param->email;
    $pass=$param->passwrd;
    $utype=$param->usrtyp;
    $fcmtoken=$param->fcm;
    $res=[];
    $sql = "SELECT * FROM user WHERE emailId='".$email."' AND userType='".$utype."'";
    $result = $conn->query($sql);
    if($result->num_rows>0){
        while(  $row = $result->fetch_assoc()){
            if($row["emailId"]===$email && $row["password"]===$pass){
                $res['status']=200;
                $res['message']="Login Successfully";
                $res['userInfo']=$row["uId"];
                // $res['ibo']=$row["ibool"];
    $sql1 = " UPDATE user SET fcmtoken = '".$fcmtoken."' WHERE emailId = '".$email."'"; 
    $result1 = $conn->query($sql1);
            }
             else
    {
        $res['status']=400;
        $res['message']="Invalid Login Details";
    }
        }
    }
    else
    {
        $res['status']=400;
        $res['message']="Invalid Login Details";
    }
    $json_data=json_encode($res);      
    echo $json_data;
}

function forgot_password($conn,$param){

    $otp = rand(100000,999999);
    $sql = "UPDATE user SET otp = '".$otp."' WHERE emailId='".$param->email."'";

    $isInserted = FALSE;

    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE && $conn->affected_rows != 0) {
            $call = new XMLHttpRequest;
            $call->open("POST", "https://hoverminds.com/SendMail/api.php?request=sendHoverMail");
            $call->setRequestHeader("Content-Type","application/json");
            $call->send('{"apiKey" : 11111,
                "email": "'.$param->email.'",
                "your_name" : "Hoverminds",
                "subject": "OTP Varification",
                "body" : "Please Verify your OTP '.$otp.'"
            }');
            echo json_encode(
            array(
                "status" => "200",
                "message" => "OTP updated"
            ));
        } else {
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Error"
                ));
        }
    }catch(Exception $e){
        echo json_encode(
            array(
                "status" => "400",
                "data" => "Already exist"
            ));
    }
}

// function otp_verify_password($conn,$param){
//     $sql = "UPDATE user SET password = '".$param->password."' WHERE emailId='".$param->email."' and otp = '".$param->otp."'";
//     $isInserted = FALSE;

//     try{
//         $isInserted = $conn->query($sql);
//         if ($isInserted === TRUE && $conn->affected_rows != 0) {
//             echo json_encode(
//             array(
//                 "status" => "200",
//                 "message" => "OTP updated"
//             ));
//         } else {
//             echo json_encode(
//                 array(
//                     "status" => "400",
//                     "data" => "Error"
//                 ));
//         }
//     }catch(Exception $e){
//         echo json_encode(
//             array(
//                 "status" => "400",
//                 "data" => "Already exist"
//             ));
//     }
// }

function profile($conn,$param){
    $mail=$param->mail;
    $utype=$param->utype;
    $res = [];
    if($utype==0){

    $sql = "SELECT uId,name,emailId,phone FROM user WHERE uId ='".$mail."'";
    $result = $conn->query($sql);
    if($result->num_rows>=0){
        while(  $row = $result->fetch_assoc()){
            array_push($res,$row);
        }
        $json_data=json_encode(array(
        "status" => "200",
        "data" => $res
    ));
    }
    }
    elseif($utype==1){
       
    $sql1 = "SELECT user.uId,user.name,user.emailId, user.phone,teacher.tId,teacher.about,teacher.photo FROM user JOIN teacher ON user.uId = teacher.tId WHERE user.uId ='".$mail."' ";
    $result1 = $conn->query($sql1);
    if($result1->num_rows>=0){
        while(  $row1 = $result1->fetch_assoc()){
            array_push($res,$row1);
        }
        $json_data=json_encode(array(
        "status" => "200",
        "data" => $res
    ));
    } 
    }
    else{
    $json_data=json_encode(array(
        "status" => "400",
        "data" => "no result"
    ));
    }
    echo $json_data;
}

function user_update($conn,$param){
 $sql = "UPDATE user SET emailId = '".$param->email."' WHERE uId = '".$param->id."'";
        
        $isInserted = FALSE;
        try{
            $isInserted = $conn->query($sql);
            if ($isInserted === TRUE) {
                echo json_encode(
                array(
                    "status" => "200",
                    "message" => "Updated"
                ));
            } else {
                echo json_encode(
                    array(
                        "status" => "400",
                        "data" => "Error"
                    ));
            }
        }catch(Exception $e){
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Already exist"
                ));
        }
}

function teacher_update($conn,$param){

    // if(!isset($param->isUpdate)){
    //     $sql = "INSERT INTO teacher(tId,about,photo)
    //     VALUES (".$param->tId.",'".$param->about."','".$param->photo."')";
        
    //     $isInserted = FALSE;
    //     try{
    //         $isInserted = $conn->query($sql);
    //         if ($isInserted === TRUE) {
    //             echo json_encode(
    //             array(
    //                 "status" => "200",
    //                 "message" => "Inserted"
    //             ));
    //         } else {
    //             echo json_encode(
    //                 array(
    //                     "status" => "400",
    //                     "data" => "Error"
    //                 ));
    //         }
    //     }catch(Exception $e){
    //         echo json_encode(
    //             array(
    //                 "status" => "400",
    //                 "data" => "Already exist"
    //             ));
    //     }
    // }else{
        $sql = "UPDATE teacher SET about = '".$param->about."', photo = '".$param->photo."' WHERE tId = ".$param->tId.";";
        
        $isInserted = FALSE;
        try{
            $isInserted = $conn->query($sql);
            if ($isInserted === TRUE) {
                echo json_encode(
                array(
                    "status" => "200",
                    "message" => "Updated"
                ));
            } else {
                echo json_encode(
                    array(
                        "status" => "400",
                        "data" => "Error"
                    ));
            }
        }catch(Exception $e){
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Already exist"
                ));
        }
    // }
}


function image_upload($conn,$param){
    // $base64string = $param->image;
    // $uploadpath   = 'uploads/';
    // $parts        = explode(";base64,", $base64string);
    // $imageparts   = explode("image/", @$parts[0]);
    // $imagetype    = $imageparts[1];
    // $imagebase64  = base64_decode($parts[1]);
    // $file         = $uploadpath . uniqid() . '.png';
    // file_put_contents($file, $imagebase64);
    // echo json_encode(
    //     array(
    //         "status" => "200",
    //         "message" => $file
    //     ));
        $myfile = fopen("upload/" . $param->name, "w") or die("Unable to open file!");
    $content= base64_decode($param->file);
    fwrite($myfile, $content);
    fclose($myfile);
    echo json_encode(
        array(
            "status" => "200",
            "data" => "Success"
        ));
}

function category($conn,$param){
    $cate=$param->cate;
    $res = [];
    $sql = "SELECT categoryName FROM category";
    $result = $conn->query($sql);
    if($result->num_rows>0){
        while(  $row = $result->fetch_assoc()){
            array_push($res,$row);
        }
        $json_data=json_encode(array(
        "status" => "200",
        "data" => $res
    ));
    }
    else{
    $json_data=json_encode(array(
        "status" => "400",
        "data" => "no result"
    ));
    }
    echo $json_data;
}

function add_catagory($conn,$param){
    $sql = "INSERT INTO category(categoryName)
    VALUES ('".$param->categoryName."')";
    
    $isInserted = FALSE;
    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE) {
            echo json_encode(
            array(
                "status" => "200",
                "message" => "Inserted"
            ));
        } else {
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Error"
                ));
        }
    }catch(Exception $e){
        echo json_encode(
            array(
                "status" => "400",
                "data" => "Already exist"
            ));
    }
}

function enroll($conn,$param)
{
     $sql = "INSERT INTO enrolledcourse(liveId,uId,cId) VALUES ('".$param->lid."','".$param->uid."','".$param->cid."')";
      $isInserted = FALSE;

    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE) {
            echo json_encode(
            array(
                "status" => "200",
                "message" => "Enrolled"
            ));
        } else {
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Not Enrolled"
                ));
        }
    }catch(Exception $e){
        echo json_encode(
            array(
                "status" => "400",
                "data" => "Already exist"
            ));
    }
}

function classdetails($conn,$param)
{
    $cate=$param->cate;
    $id=$param->uid;
    $res = [];
    $sql = "SELECT cId FROM category WHERE categoryName = '".$cate."'";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
    // $sqll = "SELECT liveId FROM enrolledcourse WHERE uId = '".$id."' AND cId ='".$row["cId"]."'";
    // $resultt = $conn->query($sqll);
    // $resultt->num_rows>0;
    // echo  $resultt->num_rows;
    // $rowr = $resultt->fetch_assoc();
    $sql1 = "SELECT liveId FROM liveclass WHERE cId ='".$row["cId"]."'";
        $result1 = $conn->query($sql1);
       if($result1->num_rows>0){
            while(  $row1 = $result1->fetch_assoc()){
        // $row1 = $result1->fetch_assoc();
    $sql2 = "SELECT liveclass.liveId,liveclass.cId,liveclass.title, liveclass.descr,timetable.day,timetable.from_time,timetable.to_time FROM liveclass JOIN timetable ON liveclass.liveId = timetable.liveId  WHERE liveclass.liveId ='".$row1["liveId"]."' ";
    $result2 = $conn->query($sql2);
    if($result2->num_rows>0){
        while(  $row2 = $result2->fetch_assoc()){
            array_push($res,$row2);
            
        }
        $json_data=json_encode(array(
        "status" => "200",
        "data" => $res
    ));
    }
            }
       }
    else{
    $json_data=json_encode(array(
        "status" => "400",
        "data" => "no result"
    ));
    }
    echo $json_data;
}

function own_class($conn,$param){
    $id=$param->uid;
    $res = [];
    $sql1 = "SELECT liveId FROM liveclass WHERE tId ='".$id."'";
        $result1 = $conn->query($sql1);
       if($result1->num_rows>0){
            while(  $row1 = $result1->fetch_assoc()){
        // $row1 = $result1->fetch_assoc();
    $sql2 = "SELECT liveclass.liveId,liveclass.cId,liveclass.title,liveclass.imname, liveclass.descr,timetable.day,timetable.from_time,timetable.to_time FROM liveclass JOIN timetable ON liveclass.liveId = timetable.liveId  WHERE liveclass.liveId ='".$row1["liveId"]."' ";
    $result2 = $conn->query($sql2);
    if($result2->num_rows>0){
        while(  $row2 = $result2->fetch_assoc()){
            array_push($res,$row2);
            
        }
        $json_data=json_encode(array(
        "status" => "200",
        "data" => $res
    ));
    }
 }
    }
    else{
    $json_data=json_encode(array(
        "status" => "400",
        "data" => "no result"
    ));
    }
    echo $json_data; 
}
function own_class1($conn,$param){
    $id=$param->uid;
    $lid=$param->lid;
    $res = [];
    $sql2 = "SELECT liveclass.liveId,liveclass.cId,liveclass.title,liveclass.imname,liveclass.descr,timetable.day,timetable.from_time,timetable.to_time FROM liveclass JOIN timetable ON liveclass.liveId = timetable.liveId  WHERE liveclass.tId ='".$id."' AND liveclass.liveId ='".$lid."' ";
    $result2 = $conn->query($sql2);
    if($result2->num_rows>0){
        while(  $row2 = $result2->fetch_assoc()){
            array_push($res,$row2);
            
        }
        $json_data=json_encode(array(
        "status" => "200",
        "data" => $res
    ));
    }
    else{
    $json_data=json_encode(array(
        "status" => "400",
        "data" => "no result"
    ));
    }
    echo $json_data; 
}


function enrolleddata($conn,$param)
{
    $id=$param->uid;
    $res = [];
    $sqll = "SELECT * FROM enrolledcourse WHERE uId = '".$id."'";
    $resultt = $conn->query($sqll);
    if($resultt->num_rows>0){
    while($rowr = $resultt->fetch_assoc()){
    $sql1 = "SELECT liveId FROM liveclass WHERE liveId ='".$rowr["liveId"]."'";
        $result1 = $conn->query($sql1);
       if($result1->num_rows>0){
            while(  $row1 = $result1->fetch_assoc()){
        // $row1 = $result1->fetch_assoc();
    $sql2 = "SELECT liveclass.liveId,liveclass.cId,liveclass.title, liveclass.descr,timetable.day,timetable.from_time,timetable.to_time FROM liveclass JOIN timetable ON liveclass.liveId = timetable.liveId  WHERE liveclass.liveId ='".$row1["liveId"]."' ";
    $result2 = $conn->query($sql2);
    if($result2->num_rows>0){
        while(  $row2 = $result2->fetch_assoc()){
            array_push($res,$row2);
            
        }
        $json_data=json_encode(array(
        "status" => "200",
        "data" => $res
    ));
    }
            }
       }
    }
    }
    else{
    $json_data=json_encode(array(
        "status" => "400",
        "data" => "no result"
    ));
    }
    echo $json_data;
}
function unenroll($conn,$param){
 $id=$param->lid;
 $res = [];
    $sql = "DELETE FROM enrolledcourse WHERE liveId = '".$id."'";
    if($result = $conn->query($sql)){
          $json_data=json_encode(array(
        "status" => "200",
        "data" => "Delete Successfully"
    ));
       
    }
    else{
    $json_data=json_encode(array(
        "status" => "400",
        "data" => "no result"
    ));
    }
   echo $json_data; 
}

// function profile1($conn,$param){
//     $mail=$param->mail;
//     $res = [];
//     $sql = "SELECT uId FROM user WHERE emailId ='".$mail."'";
//     $result = $conn->query($sql);
//     $result->num_rows>0;
//     $row = $result->fetch_assoc();
//     $sql1 = "SELECT about FROM teacher WHERE tId ='".$row["uId"]."'";
//     $result1 = $conn->query($sql1);
//     if($result1->num_rows>0){
//         while(  $row1 = $result1->fetch_assoc()){
//             array_push($res,$row1);
//         }
//         $json_data=json_encode(array(
//         "status" => "200",
//         "data" => $res
//     ));
//     }
//     else{
//     $json_data=json_encode(array(
//         "status" => "400",
//         "data" => "no result"
//     ));
//     }
//     echo $json_data;
// }

function get_all_classes_teacher($conn,$param)
{
    $sql = "SELECT * FROM liveclass Where tId = ".$param->tId;

    if(isset($param->search)){
        $sql .= " and LOWER(title) LIKE LOWER('%".$param->search."%')";
    }

    $res = [];
    $result = $conn->query($sql);
    if($result->num_rows>0){
        while(  $row = $result->fetch_assoc()){
            array_push($res,$row);
        }
    }

    $json_data=json_encode(array(
        "status" => "200",
        "data" => $res
    ));      
    echo $json_data;
}

function student_enrollment($conn,$param)
{
    $sql = "INSERT INTO enrollment(cId,uId)
    VALUES (".$param->cId.",".$param->uId.")";
    
    $isInserted = FALSE;
    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE) {
            $last = $conn->insert_id;
            echo json_encode(
            array(
                "status" => "200",
                "message" => "Inserted"
            ));
        } else {
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Error"
                ));
        }
    }catch(Exception $e){
        echo json_encode(
            array(
                "status" => "400",
                "data" => "Already exist"
            ));
    }
}


function get_all_classes($conn,$param)
{
    push_notification("test", "hello");
    $sql = "SELECT * FROM liveclass";

    if(isset($param->search)){
        $sql .= " Where LOWER(title) LIKE LOWER('%".$param->search."%')";
    }

    $res = [];
    $res2 = [];
    $result = $conn->query($sql);
    if($result->num_rows>0){
        while(  $row = $result->fetch_assoc()){
            array_push($res,$row);
        }
    }

    if($param->uId != NULL){
        $sql = "SELECT l.* FROM liveclass as l join enrollment as e on l.liveId = e.cId where e.uId = $param->uId";
        
        if(isset($param->search_enroll)){
            $sql .= " and LOWER(l.title) LIKE LOWER('%".$param->search_enroll."%')";
        }

        $result1 = $conn->query($sql);
        if($result1->num_rows>0){
            while(  $row1 = $result1->fetch_assoc()){
                array_push($res2,$row1);
            }
        }
    }

    $json_data=json_encode(array(
        "status" => "200",
        "data" => $res,
        "eroll_data" => $res2
    ));      
    echo $json_data;
}

function add_live_class($conn,$param)
{
    $tId = $param -> tId;
    $cat = $param -> cId;
    $liveLink = guidv4();
    $password = guidv4();
    // $sql1 = "SELECT uId FROM user WHERE emailId ='".$email."'";
    // $result = $conn->query($sql1);
    // $result->num_rows>0;
    // $row = $result->fetch_assoc();
    // $id=$row["uId"];
    $sql2 = "SELECT cId FROM category WHERE categoryName ='".$cat."'";
    $result1 = $conn->query($sql2);
    $result1->num_rows>0;
    $row1 = $result1->fetch_assoc();
    $cid=$row1["cId"];
    echo $cid;
    $sql = "INSERT INTO liveclass(tId,cId,liveLink,password,title,descr)
    VALUES ('".$tId."',".$cid.",'".$liveLink."','".$password."','".$param->title."','".$param->descr."')";
    
    $isInserted = FALSE;
    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE) {
            $last = $conn->insert_id;
            foreach($param->days as $value){
                $value->liveId = $last;
                add_live_time($conn,$value);
            }

            echo json_encode(
            array(
                "status" => "200",
                "message" => "Inserted"
            ));
        } else {
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Error",
                    "num" =>$sql
                ));
        }
    }catch(Exception $e){
        echo json_encode(
            array(
                "status" => "400",
                "data" => "Already exist"
            ));
    }
}

function add_live_time($conn,$param)
{
    $sql = "INSERT INTO timetable(liveId,day,from_time,to_time)
    VALUES (".$param->liveId.",'".$param->day."','".$param->from_time."','".$param->to_time."')";
    
    $isInserted = FALSE;
    
    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE) {
            return true;
        } else {
            return false;
        }
    }catch(Exception $e){
        return false;
    }
}


function guidv4($data = null) {
    // Generate 16 bytes (128 bits) of random data or use the data passed into the function.
    $data = $data ?? random_bytes(16);
    assert(strlen($data) == 16);

    // Set version to 0100
    $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
    // Set bits 6-7 to 10
    $data[8] = chr(ord($data[8]) & 0x3f | 0x80);

    // Output the 36 character UUID.
    return vsprintf('%s%s%s%s%s%s%s%s', str_split(bin2hex($data), 4));
}


function add_live_class1($conn,$param)
{
    $tId = $param -> tId;
    $lid = $param -> lId;

    $sql = "UPDATE liveclass SET title = '".$param->title."',descr = '".$param->descr."',imname = '".$param->img."' WHERE tId = '".$tId."' AND liveId ='".$lid."'";
    
    $isInserted = FALSE;
    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE) {
            $last = $conn->insert_id;
            foreach($param->days as $value){
                $value->liveId = $lid;
                add_live_time1($conn,$value);
            }

            echo json_encode(
            array(
                "status" => "200",
                "message" => "Updated"
            ));
        } else {
            echo json_encode(
                array(
                    "status" => "400",
                    "data" => "Error",
                    "num" =>$sql
                ));
        }
    }catch(Exception $e){
        echo json_encode(
            array(
                "status" => "400",
                "data" => "Already exist"
            ));
    }
}

function add_live_time1($conn,$param)
{

    $sql =     "UPDATE timetable SET day = '".$param->day."',from_time = '".$param->from_time."',to_time = '".$param->to_time."' WHERE liveId ='".$param->liveId."'";
    
    $isInserted = FALSE;
    
    try{
        $isInserted = $conn->query($sql);
        if ($isInserted === TRUE) {
            return true;
        } else {
            return false;
        }
    }catch(Exception $e){
        return false;
    }
}


?>