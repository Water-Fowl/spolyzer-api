ActiveAdmin.register Game do
  index do
    column :id
    column :created_at
    column :scores do |game|
      "#{game.score_count[:left]} - #{game.score_count[:right]}"
    end
    column :sport_id
    column :name
    column :record_user_id
    column :unit_ids do |game|
      "#{game.units[0].id} - #{game.units[1].id}"
    end
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
