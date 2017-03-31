connection: "prod-redshift"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: weight_journal_tp {

  label: "Weight Analytics"

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
explore: food_journal_workshop {
label: "Food Analytics"
sql_always_where: ${wwdate_date} >= '01-01-2017'and ${userid} = '375fad2e-3fe9-48a1-b22a-a1b5ce471f74'  ;;

}
