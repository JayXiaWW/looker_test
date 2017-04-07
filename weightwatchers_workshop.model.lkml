connection: "prod-redshift"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: weight_journal_tp {
  label: "Weight Analytics"
  join :  member_enrollment_tracking {
    sql_on: ${weight_journal_tp.userid} = ${member_enrollment_tracking.uuid} ;;
  }
  join : market {
    sql_on: ${member_enrollment_tracking.site_id} = ${market.site_id};;
  }
}

explore: member_enrollment_tracking {

label: "Enrollment Analytics"
join: market {
  sql_on: ${member_enrollment_tracking.site_id} = ${market.site_id} ;;
  }
}

explore: activity_journal {
  fields: [ALL_FIELDS*, -activity_journal.percent_of_cohort]
  join: member_enrollment_tracking {
    sql_on: ${activity_journal.userid} = ${member_enrollment_tracking.uuid}
    AND ${activity_journal.wwdate_date} >= ${member_enrollment_tracking.enrolled_date}
    AND ${activity_journal.wwdate_date} < COALESCE(${member_enrollment_tracking.cancel_date},getdate());;
    type: inner
  }
  join: cohort_sizes {
    relationship: one_to_one
    sql_on: ${member_enrollment_tracking.enrolled_week} = ${cohort_sizes.enrolled_week} ;;
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
explore: food_journal_workshop {
label: "Food Analytics"
sql_always_where: ${wwdate_date} >= '01-01-2017';;

}
