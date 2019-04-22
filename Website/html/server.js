var express = require('express');
var bodyParser = require('body-parser');
var app= express();
const path = require('path');
var mysql= require('mysql');
const router = express.Router();
app.use(bodyParser.urlencoded({ extended: true })); 

var customer_info;

var con=mysql.createConnection({
	host:"localhost",
	user:"root",
	password:"1111",
	database: "Banking"
});
var con1=mysql.createConnection({
	host:"localhost",
	user:"root",
	password:"1111",
	database: "Banking"
});

router.get('/',function(req,res){
  res.sendFile(path.join(__dirname+'/index.html'));
  //__dirname : It will resolve to your project folder.
});

router.get('/RegisterCustomer',function(req,res){
  res.sendFile(path.join(__dirname+'/RegisterCustomer.html'));
});

router.get('/sitemap',function(req,res){
  res.sendFile(path.join(__dirname+'/sitemap.html'));
});

//add the router
app.use('/', router);

app.post('/register_customer', function(req, res) {
  	console.log(req.body);
  	getCustomerCount(req.body);
  	res.render("RegisterCustomer");	
});

app.use(express.static(__dirname + '/View'));
app.use(express.static(__dirname + '/Script'));

con.connect(function(err){
	if(err)
		throw err;
	else
		console.log("Connection Established with MySQL Database.");
})

function getCustomerCount(customer_info)
{
	var count=0;
	con.query("Select count(*) as c from Customer",function(err,result)
	{
		var str=JSON.stringify(result);
		var json=JSON.parse(str);
		console.log(json[0].c);
		registerCustomer(customer_info,json[0].c);
	});
}

function registerCustomer(customer_info,count)
{
	var q="Insert into Customer values("+(count+1)+",'"+customer_info.firstname+"','"+customer_info.lastname+"','"+customer_info.birthdate+"','"+customer_info.address+"','"+customer_info.mobilenumber+"','"+customer_info.gender+"')";
	console.log(q);
	con.query(q,function(err,result){
		if(err)
			throw err;
		else
			console.log("Customer Created!");
	});
}


app.listen(8080, function() {
  console.log('Server running at http://127.0.0.1:8080/');
});