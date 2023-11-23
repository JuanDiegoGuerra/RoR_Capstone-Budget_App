module GroupsHelper
    def total_purchases(group)
        total_purchases = 0
        group.purchases.each do |purchase|
          total_purchases += purchase.amount
        end
        total_purchases
      end
end