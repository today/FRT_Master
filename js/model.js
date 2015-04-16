

function getRecipeModel(){
	var model = {};
	model.patients = {};
	model.case = getCaseModel();
	
	return model;
}

function getPatientModel(){
	var patient = {};
	
	return patient;
}

function getCaseModel(){
	var a_case = {};

	a_case.recipe = [];
	a_case.suitprice = "";
	a_case.suitcount = 0;
	a_case.sumprice = "";
	a_case.finished = false;
	a_case.shouru = 0;
	a_case.zhaoling = "";
	a_case.pay_type = "";
	a_case.a_case_no = "";
	a_case.patient_no = "";
	a_case.patient_name = "";
	a_case.mobile = "";
	a_case.patient_comment = "";
	a_case.sex = "";
	a_case.age = "";
	a_case.comment = "";
	a_case.images = [];
	a_case.doctor_name = "";
	
	return a_case;
}

function getMedicineModel(){
	var medicine = {};

	medicine.medicine_name = "";
	medicine.count = 0;
	medicine.unit = "克";
	medicine.price = "";
	medicine.xiaoji = "";

	return medicine;
}








