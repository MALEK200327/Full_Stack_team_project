class UsersCourse < Sequel::Model(:users_courses)
  many_to_one :user, key: :userID
  many_to_one :course, key: :courseID
end
