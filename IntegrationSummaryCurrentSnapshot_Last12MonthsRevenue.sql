
select 
	'# Integration Customers' as Metric,
	sum(FareHarbor) as FareHarbor,
	sum(WODTogether) as WODTogether,
	sum(The_Flybook) as The_Flybook,
	sum(Xola) as Xola,
	sum(Burble_Software) as Burble_Software,
	sum(Rezdy) as Rezdy,
	sum(Zaui) as Zaui,
	sum(Rock_Gym_Pro) as Rock_Gym_Pro,
	sum(Starboard_Suite) as Starboard_Suite,
	sum(AXIS) as AXIS,
	sum(AIMsi) as AIMsi,
	sum(TrekkSoft) as TrekkSoft,
	sum(Epicor) as Epicor,
	sum(Tourcube) as Tourcube,
	sum(FareHarbor) + 
	sum(WODTogether) + 
	sum(The_Flybook) + 
	sum(Xola) + 
	sum(Burble_Software) + 
	sum(Rezdy) + 
	sum(Zaui) + 
	sum(Rock_Gym_Pro) + 
	sum(Starboard_Suite) + 
	sum(AXIS) + 
	sum(AIMsi) + 
	sum(TrekkSoft) + 
	sum(Epicor) + 
	sum(Tourcube) as Total
from (
	select
		 if (uv_val like '%fareharbor%',1,0) as Fareharbor,
		 if (uv_val like '%starboardsuite%',1,0) as Starboard_Suite,
		 if (uv_val like '%WODTogether%',1,0) as WODTogether,
		 if (uv_val like '%Flybook%',1,0) as The_Flybook,
		 if (uv_val like '%xola%',1,0) as Xola,
		 if (uv_val like '%BurbleSoft%',1,0) as Burble_Software,
		 if (uv_val like '%Rezdy%',1,0) as Rezdy,
		 if (uv_val like '%Zaui%',1,0) as Zaui,
		 if (uv_val like '%rockgympro%',1,0) as Rock_Gym_Pro,
		 if (uv_val like '%AXIS%',1,0) as AXIS,
		 if (uv_val like '%AIMsi%',1,0) as AIMsi,
		 if (uv_val like '%TrekkSoft%',1,0) as TrekkSoft,
		 if (uv_val like '%Epicor%',1,0) as Epicor,
		 if (uv_val like '%Tourcube%',1,0) as Tourcube
	from chargify_customer cc  
	join chargify_subscription cs on cc.customer_id = cs.chrgsub_customer_id
	join user_val uu on cc.sw_customer_id = uu.uv_user_id 
	where uu.uv_name = 'api_webhookurl' 
		and cs.chrgsub_state = 'active'
	) as split 
UNION 
select 
	'% of Total # Customers' as Metric,
	(sum(FareHarbor)/totalCustomers) * 100 as FareHarborPercent,
	(sum(WODTogether)/totalCustomers) * 100 as WODTogetherPercent,
	(sum(The_Flybook)/totalCustomers) * 100 as The_FlybookPercent,
	(sum(Xola)/totalCustomers) * 100 as Xola,
	(sum(Burble_Software)/totalCustomers) * 100 as Burble_SoftwarePercent,
	(sum(Rezdy)/totalCustomers) * 100 as RezdyPercent,
	(sum(Zaui)/totalCustomers) * 100 as ZauiPercent,
	(sum(Rock_Gym_Pro)/totalCustomers) * 100 as Rock_Gym_ProPercent,
	(sum(Starboard_Suite)/totalCustomers) * 100 as Starboard_SuitePercent,
	(sum(AXIS)/totalCustomers) * 100 as AXISPercent,
	(sum(AIMsi)/totalCustomers) * 100 as AIMsiPercent,
	(sum(TrekkSoft)/totalCustomers) * 100 as TrekkSoftPercent,
	(sum(Epicor)/totalCustomers) * 100 as EpicorPercent,
	(sum(Tourcube)/totalCustomers) * 100 as TourcubePercent,
	((sum(FareHarbor) + 
	sum(WODTogether) + 
	sum(The_Flybook) + 
	sum(Xola) + 
	sum(Burble_Software) + 
	sum(Rezdy) + 
	sum(Zaui) + 
	sum(Rock_Gym_Pro) + 
	sum(Starboard_Suite) + 
	sum(AXIS) + 
	sum(AIMsi) + 
	sum(TrekkSoft) + 
	sum(Epicor) + 
	sum(Tourcube))/totalCustomers) * 100 as TotalIntegrationsPercent
from (
	select
		 if (uv_val like '%fareharbor%',1,0) as Fareharbor,
		 if (uv_val like '%starboardsuite%',1,0) as Starboard_Suite,
		 if (uv_val like '%WODTogether%',1,0) as WODTogether,
		 if (uv_val like '%Flybook%',1,0) as The_Flybook,
		 if (uv_val like '%xola%',1,0) as Xola,
		 if (uv_val like '%BurbleSoft%',1,0) as Burble_Software,
		 if (uv_val like '%Rezdy%',1,0) as Rezdy,
		 if (uv_val like '%Zaui%',1,0) as Zaui,
		 if (uv_val like '%rockgympro%',1,0) as Rock_Gym_Pro,
		 if (uv_val like '%AXIS%',1,0) as AXIS,
		 if (uv_val like '%AIMsi%',1,0) as AIMsi,
		 if (uv_val like '%TrekkSoft%',1,0) as TrekkSoft,
		 if (uv_val like '%Epicor%',1,0) as Epicor,
		 if (uv_val like '%Tourcube%',1,0) as Tourcube
	from chargify_customer cc  
	join chargify_subscription cs on cc.customer_id = cs.chrgsub_customer_id
	join user_val uu on cc.sw_customer_id = uu.uv_user_id 
	where uu.uv_name = 'api_webhookurl' 
		and cs.chrgsub_state = 'active'
	) as split 
	join (	
		select count(*) as totalCustomers
		from chargify_customer cc  
	join chargify_subscription cs on cc.customer_id = cs.chrgsub_customer_id
	where cs.chrgsub_state = 'active') total
UNION  
select 
	'Last 12 Months Integrations Revenue' as Metric,
	sum(FareHarbor)/100 as FareHarborRevenue,
	sum(WODTogether)/100 as WODTogetherRevenue,
	sum(The_Flybook)/100 as The_FlybookRevenue,
	sum(Xola)/100 as XolaRevenue,
	sum(Burble_Software)/100 as Burble_SoftwareRevenue,
	sum(Rezdy)/100 as RezdyRevenue,
	sum(Zaui)/100 as ZauiRevenue,
	sum(Rock_Gym_Pro)/100 as Rock_Gym_ProRevenue,
	sum(Starboard_Suite)/100 as Starboard_SuiteRevenue,
	sum(AXIS)/100 as AXISRevenue,
	sum(AIMsi)/100 as AIMsiRevenue,
	sum(TrekkSoft)/100 as TrekkSoftRevenue,
	sum(Epicor)/100 as EpicorRevenue,
	sum(Tourcube)/100 as TourcubeRevenue,
	(sum(FareHarbor) + 
	sum(WODTogether) + 
	sum(The_Flybook) + 
	sum(Xola) + 
	sum(Burble_Software) + 
	sum(Rezdy) + 
	sum(Zaui) + 
	sum(Rock_Gym_Pro) + 
	sum(Starboard_Suite) + 
	sum(AXIS) + 
	sum(AIMsi) + 
	sum(TrekkSoft) + 
	sum(Epicor) + 
	sum(Tourcube))/100 as TotalIntegrationsRevenue
from (
	select
		 if (uv_val like '%fareharbor%',sum(ct.amount_in_cents),0) as Fareharbor,
		 if (uv_val like '%starboardsuite%',sum(ct.amount_in_cents),0) as Starboard_Suite,
		 if (uv_val like '%WODTogether%',sum(ct.amount_in_cents),0) as WODTogether,
		 if (uv_val like '%Flybook%',sum(ct.amount_in_cents),0) as The_Flybook,
		 if (uv_val like '%xola%',sum(ct.amount_in_cents),0) as Xola,
		 if (uv_val like '%BurbleSoft%',sum(ct.amount_in_cents),0) as Burble_Software,
		 if (uv_val like '%Rezdy%',sum(ct.amount_in_cents),0) as Rezdy,
		 if (uv_val like '%Zaui%',sum(ct.amount_in_cents),0) as Zaui,
		 if (uv_val like '%rockgympro%',sum(ct.amount_in_cents),0) as Rock_Gym_Pro,
		 if (uv_val like '%AXIS%',sum(ct.amount_in_cents),0) as AXIS,
		 if (uv_val like '%AIMsi%',sum(ct.amount_in_cents),0) as AIMsi,
		 if (uv_val like '%TrekkSoft%',sum(ct.amount_in_cents),0) as TrekkSoft,
		 if (uv_val like '%Epicor%',sum(ct.amount_in_cents),0) as Epicor,
		 if (uv_val like '%Tourcube%',sum(ct.amount_in_cents),0) as Tourcube
	from chargify_customer cc  
	join chargify_subscription cs on cc.customer_id = cs.chrgsub_customer_id
	join chargify_transactions ct on ct.subscription_id = cs.chrgsub_id 
	join user_val uu on cc.sw_customer_id = uu.uv_user_id 
	where uu.uv_name = 'api_webhookurl' 
		and cs.chrgsub_state = 'active'
		and date(ct.created_at) >= date_add(curdate(), interval -1 year)
		and ct.success = 1
		and ct.transaction_type = 'payment'
	group by ct.subscription_id 
	) as split 
UNION  
select 
	'% of Last 12 Months Total Revenue' as Metric,
	(sum(FareHarbor)/100)/totalCustomerRevenue * 100 as FareHarborRevenuePct,
	(sum(WODTogether)/100)/totalCustomerRevenue * 100 as WODTogetherRevenuePct,
	(sum(The_Flybook)/100)/totalCustomerRevenue * 100 as The_FlybookRevenuePct,
	(sum(Xola)/100)/totalCustomerRevenue * 100 as XolaRevenuePct,
	(sum(Burble_Software)/100)/totalCustomerRevenue * 100 * 100 as Burble_SoftwareRevenuePct,
	(sum(Rezdy)/100)/totalCustomerRevenue * 100 as RezdyRevenuePct,
	(sum(Zaui)/100)/totalCustomerRevenue * 100 as ZauiRevenuePct,
	(sum(Rock_Gym_Pro)/100)/totalCustomerRevenue * 100 as Rock_Gym_ProRevenuePct,
	(sum(Starboard_Suite)/100)/totalCustomerRevenue * 100 as Starboard_SuiteRevenuePct,
	(sum(AXIS)/100)/totalCustomerRevenue * 100 as AXISRevenuePct,
	(sum(AIMsi)/100)/totalCustomerRevenue * 100 as AIMsiRevenuePct,
	(sum(TrekkSoft)/100)/totalCustomerRevenue * 100 as TrekkSoftRevenuePct,
	(sum(Epicor)/100)/totalCustomerRevenue * 100 as EpicorRevenuePct,
	(sum(Tourcube)/100)/totalCustomerRevenue * 100 as TourcubeRevenuePct,
	((sum(FareHarbor) + 
	sum(WODTogether) + 
	sum(The_Flybook) + 
	sum(Xola) + 
	sum(Burble_Software) + 
	sum(Rezdy) + 
	sum(Zaui) + 
	sum(Rock_Gym_Pro) + 
	sum(Starboard_Suite) + 
	sum(AXIS) + 
	sum(AIMsi) + 
	sum(TrekkSoft) + 
	sum(Epicor) + 
	sum(Tourcube))/100)/totalCustomerRevenue * 100 as TotalIntegrationsRevenuePct
from (
	select
		 if (uv_val like '%fareharbor%',sum(ct.amount_in_cents),0) as Fareharbor,
		 if (uv_val like '%starboardsuite%',sum(ct.amount_in_cents),0) as Starboard_Suite,
		 if (uv_val like '%WODTogether%',sum(ct.amount_in_cents),0) as WODTogether,
		 if (uv_val like '%Flybook%',sum(ct.amount_in_cents),0) as The_Flybook,
		 if (uv_val like '%xola%',sum(ct.amount_in_cents),0) as Xola,
		 if (uv_val like '%BurbleSoft%',sum(ct.amount_in_cents),0) as Burble_Software,
		 if (uv_val like '%Rezdy%',sum(ct.amount_in_cents),0) as Rezdy,
		 if (uv_val like '%Zaui%',sum(ct.amount_in_cents),0) as Zaui,
		 if (uv_val like '%rockgympro%',sum(ct.amount_in_cents),0) as Rock_Gym_Pro,
		 if (uv_val like '%AXIS%',sum(ct.amount_in_cents),0) as AXIS,
		 if (uv_val like '%AIMsi%',sum(ct.amount_in_cents),0) as AIMsi,
		 if (uv_val like '%TrekkSoft%',sum(ct.amount_in_cents),0) as TrekkSoft,
		 if (uv_val like '%Epicor%',sum(ct.amount_in_cents),0) as Epicor,
		 if (uv_val like '%Tourcube%',sum(ct.amount_in_cents),0) as Tourcube
	from chargify_customer cc  
	join chargify_subscription cs on cc.customer_id = cs.chrgsub_customer_id
	join chargify_transactions ct on ct.subscription_id = cs.chrgsub_id 
	join user_val uu on cc.sw_customer_id = uu.uv_user_id 
	where uu.uv_name = 'api_webhookurl' 
		and cs.chrgsub_state = 'active'
		and date(ct.created_at) >= date_add(curdate(), interval -1 year)
		and ct.success = 1
		and ct.transaction_type = 'payment'
	group by ct.subscription_id 
	) as split 
	join (	
		select sum(ct.amount_in_cents)/100 as totalCustomerRevenue
		from chargify_customer cc  
	join chargify_subscription cs on cc.customer_id = cs.chrgsub_customer_id
	join chargify_transactions ct on ct.subscription_id = cs.chrgsub_id 
	where cs.chrgsub_state = 'active' 
		and date(ct.created_at) >= date_add(curdate(), interval -1 year)
		and ct.success = 1
		and ct.transaction_type = 'payment') total
	

	
		
	 