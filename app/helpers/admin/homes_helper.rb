module Admin::HomesHelper
def TS_chart
 [ {name: "Shipper" ,data: ReceivingRequest.group_by_day(:created_at).count,library: {curveType: "none", pointSize: 0}},{ name: "Traveller" ,data: Traveller.group_by_day(:created_at).count} ] 
end

end
