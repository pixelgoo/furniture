class UserSettingsService

  def self.settings(user)
    furnitures = Furniture.all
    regions = Region.all
    settings = {
      'regions' => regions,
      'regions_ids' => regions.ids,
      'user_regions_ids' => user.region_ids,

      'furnitures' => furnitures,
      'furnitures_ids' => furnitures.ids,
      'user_furnitures_ids' => user.furniture_ids
    }
  end

  def initialize(params, user)
    @model = params[:model]
    @settings = params[:set_model]
    @user = user
  end

  def validate
    is_valid? && is_applicable?
  end

  def update
    model_objects = @model.capitalize.constantize.all
    user_model_objects = @user.send("#{@model}s")
    user_model_objects_ids = user_model_objects.ids
    objects_to_delete = []
    @settings.delete("set_all_#{@model}")
    @settings.each do |index, checked|
      model_object = model_objects[index.scan(/\d+/).first.to_i - 1]
      if checked == '1'
        user_model_objects << model_object unless user_model_objects_ids.include? model_object.id
      else 
        objects_to_delete.push model_object.id
      end
    end
    user_model_objects.delete(*(objects_to_delete & user_model_objects.ids))
  end

  private

  def is_valid?
    User::SETTINGS_AVAILABLE.include?(@model.to_sym)
  end

  def is_applicable?
    return true if TrialPolicy.trial_access(@user)
    return @user.tariff.region_counter > @user.regions.length if @model == 'region'
    true
  end

end