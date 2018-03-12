
set @startDate = '2018-01-01';
set @endDate = curdate();

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
		 if (uv_val like '%fareharbor%' and u.date >= '2015-06-15',1,0) as Fareharbor,
		 if (uv_val like '%starboardsuite%' and u.date >= '2016-05-16',1,0) as Starboard_Suite,
		 if (uv_val like '%WODTogether%' and u.date >= '2014-09-01',1,0) as WODTogether,
		 if (uv_val like '%Flybook%' and u.date >= '2014-06-01',1,0) as The_Flybook,
		 if (uv_val like '%xola%' and u.date >= '2016-01-15',1,0) as Xola,
		 if (uv_val like '%BurbleSoft%' and u.date >= '2013-03-15',1,0) as Burble_Software,
		 if (uv_val like '%Rezdy%' and u.date >= '2016-03-14',1,0) as Rezdy,
		 if (uv_val like '%Zaui%' and u.date >= '2017-09-27',1,0) as Zaui,
		 if (uv_val like '%rockgympro%',1,0) as Rock_Gym_Pro,
		 if (uv_val like '%AXIS%' and u.date >= '2017-06-16',1,0) as AXIS,
		 if (uv_val like '%AIMsi%' and u.date >= '2016-01-15',1,0) as AIMsi,
		 if (uv_val like '%TrekkSoft%' and u.date >= '2017-11-16',1,0) as TrekkSoft,
		 if (uv_val like '%Epicor%' and u.date >= '2017-10-17',1,0) as Epicor,
		 if (uv_val like '%Tourcube%' and u.date >= '2016-07-01',1,0) as Tourcube
	from chargify_customer cc  
	join chargify_subscription cs on cc.customer_id = cs.chrgsub_customer_id
	join user_val uu on cc.sw_customer_id = uu.uv_user_id 
	join wms_user u on uu.uv_user_id = u.id 
	where uu.uv_name = 'api_webhookurl' 
		and cs.chrgsub_state = 'active'
	) as split 
UNION  
select 
	'Integrations Revenue' as Metric,
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
		 if (uv_val like '%fareharbor%' and u.date >= '2015-06-15',sum(ct.amount_in_cents),0) as Fareharbor,
		 if (uv_val like '%starboardsuite%' and u.date >= '2016-05-16',sum(ct.amount_in_cents),0) as Starboard_Suite,
		 if (uv_val like '%WODTogether%' and u.date >= '2014-09-01',sum(ct.amount_in_cents),0) as WODTogether,
		 if (uv_val like '%Flybook%' and u.date >= '2014-06-01',sum(ct.amount_in_cents),0) as The_Flybook,
		 if (uv_val like '%xola%' and u.date >= '2016-01-15',sum(ct.amount_in_cents),0) as Xola,
		 if (uv_val like '%BurbleSoft%' and u.date >= '2013-03-15',sum(ct.amount_in_cents),0) as Burble_Software,
		 if (uv_val like '%Rezdy%' and u.date >= '2016-03-14',sum(ct.amount_in_cents),0) as Rezdy,
		 if (uv_val like '%Zaui%' and u.date >= '2017-09-27',sum(ct.amount_in_cents),0) as Zaui,
		 if (uv_val like '%rockgympro%',sum(ct.amount_in_cents),0) as Rock_Gym_Pro,
		 if (uv_val like '%AXIS%' and u.date >= '2017-06-16',sum(ct.amount_in_cents),0) as AXIS,
		 if (uv_val like '%AIMsi%' and u.date >= '2016-01-15',sum(ct.amount_in_cents),0) as AIMsi,
		 if (uv_val like '%TrekkSoft%' and u.date >= '2017-11-16',sum(ct.amount_in_cents),0) as TrekkSoft,
		 if (uv_val like '%Epicor%' and u.date >= '2017-10-17',sum(ct.amount_in_cents),0) as Epicor,
		 if (uv_val like '%Tourcube%' and u.date >= '2016-07-01',sum(ct.amount_in_cents),0) as Tourcube
	from chargify_customer cc  
	join chargify_subscription cs on cc.customer_id = cs.chrgsub_customer_id
	join chargify_transactions ct on ct.subscription_id = cs.chrgsub_id 
	join user_val uu on cc.sw_customer_id = uu.uv_user_id 
	join wms_user u on uu.uv_user_id = u.id 
	where uu.uv_name = 'api_webhookurl' 
		and cs.chrgsub_state = 'active'
		and date(ct.created_at) between @startDate and @endDate
		and ct.success = 1
		and ct.transaction_type = 'payment'
	group by u.id 
	) as split 