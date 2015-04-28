<#
Автор: Anton Drelin <antondrelin@gmail.com>
#>
$config = @(		
	@("77:00:0000000:",4001,5000),
	@("77:00:0000000:",5001,6000),
	@("77:00:0000000:",6001,7000),	
	@("77:00:0000000:",7001,8000),	
	@("77:00:0000000:",8001,9000),	
	@("77:00:0000000:",9001,10000)
)

ForEach($cf in $config){		
	Start-Job -Scriptblock {E:\function_insert.ps1 $args[0] $args[1] $args[2]} -ArgumentList($cf[0],$cf[1],$cf[2])
}
