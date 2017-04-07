connection: "prod-redshift"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project


explore: member_enrollment_tracking {
  label: "Subscription Analytics"
  view_label: "Subscriptions"
  persist_for: "12 hours"
}

explore: subscriptions {
  persist_for: "12 hours"
  extension: required
  from: member_enrollment_tracking
  view_name: member_enrollment_tracking
  view_label: "Subscriptions"

  always_filter: {
    filters: {
      field: dates.event_date
      value: "30 days"
    }
  }

  join: cohort_sizes {
    view_label: "Subscriptions"
    relationship: one_to_one
    sql_on: ${member_enrollment_tracking.enrolled_week} = ${cohort_sizes.enrolled_week} ;;
    fields: [cohort_sizes.max_cohort_size]
  }

  join: user_profile {
    sql_on: ${member_enrollment_tracking.uuid} = ${user_profile.userid} ;;
    relationship: many_to_one
    fields: [user_profile.goal_weight_lbs,user_profile.registrationdate_date,user_profile.registrationdate_week, user_profile.registrationdate_month, user_profile.registrationdate_year, user_profile.count]
  }

  join: dates {
    type: inner
    relationship: many_to_many
    sql_on: ${member_enrollment_tracking.enrolled_date} <= ${dates.event_date}
      AND ${member_enrollment_tracking.enrollment_ends_date} > ${dates.event_date};;
  }

}

explore: subscriptions_and_activity {
  persist_for: "12 hours"
  extends: [subscriptions]
  fields: [ALL_FIELDS*, -activity_journal.percent_of_cohort, -activity_journal.weeks_since_pilot_start, -activity_journal.weeks_since_enrollment]

  join: activity_journal {
    sql_on: ${dates.event_date} = ${activity_journal.wwdate_date}
          AND ${member_enrollment_tracking.uuid} = ${activity_journal.userid}
          AND {% condition dates.event_date %} ${activity_journal.wwdate_date} {% endcondition %} ;;
    relationship: one_to_many
  }
}

explore: subscriptions_and_food {
  hidden: yes
  extends: [subscriptions]
  fields: [ALL_FIELDS*, -food_journal.percent_of_cohort, -food_journal.weeks_since_pilot_start, -food_journal.weeks_since_enrollment]

  join: food_journal {
    sql_on: ${dates.event_date} = ${food_journal.wwdate_date}
          AND ${member_enrollment_tracking.uuid} = ${food_journal.userid}
          AND {% condition dates.event_date %} ${food_journal.wwdate_date} {% endcondition %} ;;
    relationship: one_to_many
  }
}

explore: subscriptions_and_weight {
  # hidden: yes
  persist_for: "12 hours"
  extends: [subscriptions]
  fields: [ALL_FIELDS*, -weight_journal.percent_of_cohort, -weight_journal.weeks_since_pilot_start, -weight_journal.weeks_since_enrollment]

  join: weight_journal {
    sql_on: ${dates.event_date} = ${weight_journal.wwdate_date}
          AND ${member_enrollment_tracking.uuid} = ${weight_journal.userid}
          AND {% condition dates.event_date %} ${weight_journal.wwdate_date} {% endcondition %} ;;
    relationship: one_to_many
  }
}






# Whisper Explores
# ___________________________________________________________________________________________________

explore: activity_journal {
  hidden: yes
  fields: [ALL_FIELDS*, -activity_journal.percent_of_enrollment_week_cohort]
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
  join: member_enrollment_tracking {
    sql_on: ${activity_journal.userid} = ${member_enrollment_tracking.uuid}
          AND ${activity_journal.wwdate_date} >= ${member_enrollment_tracking.enrolled_date}
          AND ${activity_journal.wwdate_date} < COALESCE(${member_enrollment_tracking.cancel_date},getdate());;
  }

  always_filter: {
    filters: {
      field: whisper_user_role_events_snap_20170321.rolename
      value: "rewards-2017-jan-online-control,rewards-2017-jan-online-high,rewards-2017-jan-online-low,rewards-2017-jan-meetings-conrol,rewards-2017-jan-meetings-high,rewards-2017-jan-meetings-low"
      }
    }
}

explore: food_journal {
  hidden: yes
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
  join: member_enrollment_tracking {
    sql_on: ${food_journal.userid} = ${member_enrollment_tracking.uuid}
          AND ${food_journal.wwdate_date} >= ${member_enrollment_tracking.enrolled_date}
          AND ${food_journal.wwdate_date} < COALESCE(${member_enrollment_tracking.cancel_date},getdate());;
  }
  always_filter: {
    filters: {
      field: whisper_user_role_events_snap_20170321.rolename
      value: "rewards-2017-jan-online-control,rewards-2017-jan-online-high,rewards-2017-jan-online-low,rewards-2017-jan-meetings-conrol,rewards-2017-jan-meetings-high,rewards-2017-jan-meetings-low"
    }
  }
}

explore: weight_journal {
  hidden: yes
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

  join: weight_loss_log {
    sql_on: ${whisper_user_role_events_snap_20170321.userid} = ${weight_loss_log.userid}
      AND ${weight_journal.weeks_since_pilot_start} = ${weight_loss_log.weeks_since_pilot_start};;
    type: inner
    relationship: one_to_one
  }
  join: user_profile {
    sql_on: ${weight_journal.userid} = ${user_profile.userid}  ;;
    relationship: many_to_one
  }
  join: member_enrollment_tracking {
    sql_on: ${weight_journal.userid} = ${member_enrollment_tracking.uuid}
          AND ${weight_journal.wwdate_date} >= ${member_enrollment_tracking.enrolled_date}
          AND ${weight_journal.wwdate_date} < COALESCE(${member_enrollment_tracking.cancel_date},getdate());;
  }
  always_filter: {
    filters: {
      field: whisper_user_role_events_snap_20170321.rolename
      value: "rewards-2017-jan-online-control,rewards-2017-jan-online-high,rewards-2017-jan-online-low,rewards-2017-jan-meetings-conrol,rewards-2017-jan-meetings-high,rewards-2017-jan-meetings-low"
    }
  }
}

explore: whisper_user_role_events_snap_20170321 {
  hidden: yes
  label: "Whisper User Profiles"
  join: user_profile {
    type: inner
    sql_on: ${whisper_user_role_events_snap_20170321.userid} = ${user_profile.userid} ;;
    relationship: one_to_one
  }
  always_filter: {
    filters: {
      field: whisper_user_role_events_snap_20170321.rolename
      value: "rewards-2017-jan-online-control,rewards-2017-jan-online-high,rewards-2017-jan-online-low,rewards-2017-jan-meetings-conrol,rewards-2017-jan-meetings-high,rewards-2017-jan-meetings-low"
    }
  }
}


# explore: dates {
#   join: member_enrollment_tracking {
#     type: inner
#     sql_on: ${dates.event_date} >= ${member_enrollment_tracking.enrolled_date}
#     AND ${dates.event_date} <= ${member_enrollment_tracking.enrollment_ends_date} ;;
#     relationship: one_to_many
#   }
# }
