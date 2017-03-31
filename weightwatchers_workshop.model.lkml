connection: "prod-redshift"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: weight_journal_tp {
  label: "Weight Analytics"
  join :  member_enrollment_tracking_snap_20170329 {
    sql_on: ${weight_journal_tp.userid} = ${member_enrollment_tracking_snap_20170329.uuid} ;;
  }
  join : market {
    sql_on: ${member_enrollment_tracking_snap_20170329.site_id} = ${market.site_id};;
  }
}

explore: member_enrollment_tracking_snap_20170329 {

label: "Enrollment Analytics"
join: market {
  sql_on: ${member_enrollment_tracking_snap_20170329.site_id} = ${market.site_id} ;;
  }
}

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     sql_on: ${orders.id} = ${order_items.order_id}
#   }
#
#   join: users {
#     sql_on: ${users.id} = ${orders.user_id}
#   }
# }
