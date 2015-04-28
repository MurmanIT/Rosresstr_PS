param([string]$cadnumber,[long]$number_begin,[long]$number_end)

[void][system.reflection.Assembly]::LoadFrom("C:\Program Files (x86)\MySQL\MySQL Connector Net 6.9.6\Assemblies\v4.5\MySQL.Data.dll")

function global:Set-SqlConnection ( 
	$server = $(Read-Host "SQL Server Name"), 
	$username = $(Read-Host "Username"), 
	$password = $(Read-Host "Password"), 
	$database = $(Read-Host "Default Database") ) {
    $SqlConnection.ConnectionString = "server=$server;user id=$username;password=$password;database=$database;pooling=false;Allow Zero Datetime=True;"
}

function global:Get-SqlDataTable( $Query = $(if (-not ($Query -gt $null)) {Read-Host "Query to run"}) ) {
	if (-not ($SqlConnection.State -like "Open")) { $SqlConnection.Open() }
	$SqlCmd = New-Object MySql.Data.MySqlClient.MySqlCommand $Query, $SqlConnection
	$SqlAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
	$SqlAdapter.SelectCommand = $SqlCmd
	$DataSet = New-Object System.Data.DataSet
	$SqlAdapter.Fill($DataSet) | Out-Null
	$SqlConnection.Close()
	return $DataSet.Tables[0]
}

function InsertMySQL{
	param([string]$cadnumber,[long]$number_begin,[long]$number_end)
	$mysql_config = @("localhost","root","520053100server","archive_base")	
	
	Set-Variable SqlConnection (New-Object MySql.Data.MySqlClient.MySqlConnection) -Scope Global -Option AllScope -Description "Personal variable for Sql Query functions"
	Set-SqlConnection $mysql_config[0] $mysql_config[1] $mysql_config[2] $mysql_config[3]	
	
	for($i=$number_begin; $i -le $number_end; $i++){
		$element = $cadnumber + $i
		$url = "http://maps.rosreestr.ru/arcgis/rest/services/Cadastre/CadastreSelected/MapServer/exts/GKNServiceExtension/online/parcel/find?cadNum="+$element+"&onlyAttributes=false&f=json";
		$j = Invoke-WebRequest -Uri  $url | ConvertFrom-Json
	If($j.featuresCount -eq 1){
			$string = "'" + $j.features[0].attributes.CAD_NUM +"','"+ `
			$j.features[0].attributes.OBJECT_ID +"','"+ `
			$j.features[0].attributes.REGION_KEY +"','"+ `
			$j.features[0].attributes.PARCEL_CN +"','"+ `
			$j.features[0].attributes.PARCEL_STATUS +"','"+ `
			$j.features[0].attributes.DATE_CREATE +"','"+ `
			$j.features[0].attributes.DATE_REMOVE +"','"+ `
			$j.features[0].attributes.CATEGORY_TYPE +"','"+ `
			$j.features[0].attributes.AREA_VALUE +"','"+ `
			$j.features[0].attributes.AREA_TYPE +"','"+ `
			$j.features[0].attributes.AREA_UNIT +"','"+ `
			$j.features[0].attributes.RIGHT_REG +"','"+ `
			$j.features[0].attributes.CAD_COST +"','"+ `
			$j.features[0].attributes.CAD_UNIT +"','"+ `
			$j.features[0].attributes.DATE_COST +"','"+ `
			$j.features[0].attributes.ONLINE_ACTUAL_DATE +"','"+ `
			$j.features[0].attributes.PARENT_ID +"','"+ `
			$j.features[0].attributes.OBJECT_ADDRESS +"','"+ `
			$j.features[0].attributes.DATE_LOAD +"','"+ `
			$j.features[0].attributes.CI_SURNAME +"','"+ `
			$j.features[0].attributes.CI_FIRST +"','"+ `
			$j.features[0].attributes.CI_PATRONYMIC +"','"+ `
			$j.features[0].attributes.RC_DATE +"','"+ `
			$j.features[0].attributes.RC_TYPE +"','"+ `
			$j.features[0].attributes.CO_NAME +"','"+ `
			$j.features[0].attributes.CO_INN +"','"+ `
			$j.features[0].attributes.OBJECT_DISTRICT +"','"+ `
			$j.features[0].attributes.DISTRICT_TYPE +"','"+ `
			$j.features[0].attributes.OBJECT_PLACE +"','"+ `
			$j.features[0].attributes.PLACE_TYPE +"','"+ `
			$j.features[0].attributes.OBJECT_LOCALITY +"','"+ `
			$j.features[0].attributes.LOCALITY_TYPE +"','"+ `
			$j.features[0].attributes.OBJECT_STREET +"','"+ `
			$j.features[0].attributes.STREET_TYPE +"','"+ `
			$j.features[0].attributes.OBJECT_HOUSE +"','"+ `
			$j.features[0].attributes.OBJECT_BUILDING +"','"+ `
			$j.features[0].attributes.OBJECT_STRUCTURE +"','"+ `
			$j.features[0].attributes.OBJECT_APARTMENT +"','"+ `
			$j.features[0].attributes.UTIL_BY_DOC +"','"+ `
			$j.features[0].attributes.UTIL_CODE +"','"+ `
			$j.features[0].attributes.OKS_FLAG +"','"+ `
			$j.features[0].attributes.OKS_TYPE +"','"+ `
			$j.features[0].attributes.OKS_FLOORS +"','"+ `
			$j.features[0].attributes.OKS_U_FLOORS +"','"+ `
			$j.features[0].attributes.OKS_ELEMENTS_CONSTRUCT +"','"+ `
			$j.features[0].attributes.OKS_YEAR_USED +"','"+ `
			$j.features[0].attributes.OKS_INVENTORY_COST +"','"+ `
			$j.features[0].attributes.OKS_INN +"','"+ `
			$j.features[0].attributes.OKS_EXECUTOR +"','"+ `
			$j.features[0].attributes.YEAR_BUILT +"','"+ `
			$j.features[0].attributes.OKS_COST_DATE +"','"+ `
			$j.features[0].attributes.FORM_RIGHTS +"','"+ `
			$j.features[0].attributes.OBJECTID +"','"+ `
			$j.features[0].attributes.PARCEL_ID +"','"+ `
			$j.features[0].attributes.TEMP_ID +"','"+ `
			$j.features[0].attributes.PKK_ID +"','"+ `
			$j.features[0].attributes.STATE_CODE +"','"+ `
			$j.features[0].attributes.ANNO_TEXT +"','"+ `
			$j.features[0].attributes.CP_VALUE +"','"+ `
			$j.features[0].attributes.CATEGORY_CODE +"','"+ `
			$j.features[0].attributes.ACTUAL_DATE +"','"+ `
			$j.features[0].attributes.ERROR_CODE +"','"+ `
			$j.features[0].attributes.XC +"','"+ `
			$j.features[0].attributes.YC +"','"+ `
			$j.features[0].attributes.XMIN +"','"+ `
			$j.features[0].attributes.XMAX +"','"+ `
			$j.features[0].attributes.YMIN +"','"+ `
			$j.features[0].attributes.YMAX +"','"+ `
			$j.features[0].attributes.DEL_FEATURE +"','"+ `
			$j.features[0].attributes.G_AREA +"','"+ `
			$j.features[0].attributes.SHAPE_Length +"','"+ `
			$j.features[0].attributes.SHAPE_Area +"','"+ `
			$j.features[0].attributes.OKS_ID +"','"+ `
			$j.features[0].attributes.CAD_NUM_OLD +"','"+ `
			$j.features[0].attributes.NAME +"','"+ `
			$j.features[0].attributes.PARCEL_CADNUM +"','"+ `
			$j.features[0].attributes.ERRORCODE + "'"
			$global:Query = "CALL insert_fast_msk(" + $string + ")"
			Get-SqlDataTable $Query
		}
	}	
}

InsertMySQL -cadnumber $cadnumber -number_begin $number_begin -number_end $number_end