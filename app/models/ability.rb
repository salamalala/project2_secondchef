class Ability

    include CanCan::Ability

    def initialize(user)
        user ||= User.new
        if user.role? :admin

            can :manage, :all

        elsif user.role? :chef

            # can read basics, as per anonymous user
            can :read, [Category, Meal, Review]
            can :read, User, role: "chef"

            # can read own orders, both those placed and those received
            can :read, Order do |order|
                order.user.id == user.id || order.meal.user.id == user.id
            end
            # can place order, but not for own meal (NOT WORKING)
            can :create, Order do |order|
                order.meal.user.id != user.id
            end

            # can create, update and destroy reviews on own orders
            can [:create, :update, :destroy], Review do |review|
                review.order.user.id == user.id
            end

            # can update chef profile
            can :update, User, id: user.id

            # can create meal
            can :create, Meal

            # can update own meals
            can :update, Meal, user_id: user.id

            # can destroy own meal but only if no dependents
            can :destroy, Meal do |meal|
                meal.user.id == user.id && meal.orders.count == 0
            end

        elsif user.persisted?

            # can read basics, as per anonymous user
            can :read, [Category, Meal, Review]
            can :read, User, role: "chef"

            # can read own orders
            can :read, Order do |order|
                order.user.id == user.id
            end

            # can place order if the meal is available and current (NOT WORKING)
            can :create, Order do |order|
                order.meal.available? && order.meal.current?
            end

            # can create, update and destroy reviews on own orders
            can [:create, :update, :destroy], Review do |review|
                review.order.user.id == user.id
            end

            # can "create" (but really "update") chef profile
            can :update, User, id: user.id

        else # anonymous user

            # can read basics
            can :read, [Category, Meal, Review]
            can :read, User, role: "chef"
        
        end
    end

<<<<<<< HEAD

=======
>>>>>>> 07d80da35879576c34708fd3285e7b345a873aab
end
