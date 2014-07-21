module ComponentsHelper
  def get_all_atmosphere_components
    res = []
    Component.all.each do |c|
      if c.atmosphere?
        res.push c
      end
    end
    return res
  end

  def get_all_ocean_components
    res = []
    Component.all.each do |c|
      if c.ocean?
        res.push c
      end
    end
    return res
  end

  def get_all_land_components
    res = []
    Component.all.each do |c|
      if c.land?
        res.push c
      end
    end
    return res
  end

  def get_all_sea_ice_components
    res = []
    Component.all.each do |c|
      if c.sea_ice?
        res.push c
      end
    end
    return res
  end
end
