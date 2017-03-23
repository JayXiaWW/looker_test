connection: "prod-redshift"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: activity_journal {
  label: "Whisper Effect on Activity"
  sql_always_where: ${wwdate_date} > '01-01-2017' ;;
  join: whisper_user_role_events_snap_20170321 {
    view_label: "Whisper Users"
    sql_on: ${activity_journal.userid} = ${whisper_user_role_events_snap_20170321.userid} ;;
    type: inner
    relationship: many_to_one
  }
  join: group_sizes {
    sql_on: ${whisper_user_role_events_snap_20170321.rolename} = ${group_sizes.rolename} ;;
    type: left_outer
    relationship: one_to_one
  }
  always_filter: {
    filters: {
      field: whisper_user_role_events_snap_20170321.rolename
      value: "rewards-2017-jan-online-control,rewards-2017-jan-online-high,rewards-2017-jan-online-low,rewards-2017-jan-meetings-conrol,rewards-2017-jan-meetings-high,rewards-2017-jan-meetings-low"
      }
    }
}

explore: food_journal {
  label: "Whisper Effect on Food Entry"
  sql_always_where: ${wwdate_date} > '01-01-2017' ;;
  join: whisper_user_role_events_snap_20170321 {
    view_label: "Whisper Users"
    sql_on: ${food_journal.userid} = ${whisper_user_role_events_snap_20170321.userid} ;;
    type: inner
    relationship: many_to_one
  }
  join: group_sizes {
    sql_on: ${whisper_user_role_events_snap_20170321.rolename} = ${group_sizes.rolename} ;;
    type: left_outer
    relationship: one_to_one
  }
  always_filter: {
    filters: {
      field: whisper_user_role_events_snap_20170321.rolename
      value: "rewards-2017-jan-online-control,rewards-2017-jan-online-high,rewards-2017-jan-online-low,rewards-2017-jan-meetings-conrol,rewards-2017-jan-meetings-high,rewards-2017-jan-meetings-low"
    }
  }
}

explore: weight_journal {
  label: "Whisper Effect on Weigh-In"
  sql_always_where: ${wwdate_date} > '01-01-2017' ;;
  join: whisper_user_role_events_snap_20170321 {
    view_label: "Whisper Users"
    sql_on: ${weight_journal.userid} = ${whisper_user_role_events_snap_20170321.userid} ;;
    type: inner
    relationship: many_to_one
  }
  join: group_sizes {
    sql_on: ${whisper_user_role_events_snap_20170321.rolename} = ${group_sizes.rolename} ;;
    type: left_outer
    relationship: one_to_one
  }
  always_filter: {
    filters: {
      field: whisper_user_role_events_snap_20170321.rolename
      value: "rewards-2017-jan-online-control,rewards-2017-jan-online-high,rewards-2017-jan-online-low,rewards-2017-jan-meetings-conrol,rewards-2017-jan-meetings-high,rewards-2017-jan-meetings-low"
    }
  }
}





# explore: whisper_user_role_events_snap_20170321 {
#   label: "Whisper effect"
#   always_filter: {
#     filters: {
#       field: whisper_user_role_events_snap_20170321.rolename
#       value: "rewards-2017-jan-online-control,rewards-2017-jan-online-high,rewards-2017-jan-online-low,rewards-2017-jan-meetings-conrol,rewards-2017-jan-meetings-high,rewards-2017-jan-meetings-low"
#     }
#   }
#   join: activity_journal {
#     sql_on: ${whisper_user_role_events_snap_20170321.userid} = ${activity_journal.userid}   ;;
#     type: left_outer
#     relationship: one_to_many
#   }

#   join: group_sizes {
#     sql_on: ${whisper_user_role_events_snap_20170321.rolename} = ${group_sizes.rolename} ;;
#     type: inner
#     relationship: one_to_one
#   }
# }
#   join: food_journal {
#     sql_on: ${whisper_user_role_events_snap_20170321.userid} = ${food_journal.userid}   ;;
#     type: inner
#     relationship: one_to_many
#   }
#   join: weight_journal {
#     sql_on: ${whisper_user_role_events_snap_20170321.userid} = ${weight_journal.userid}   ;;
#     type: inner
#     relationship: one_to_many
#   }
# }
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
