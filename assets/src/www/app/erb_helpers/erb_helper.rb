
module ErbHelper
  def ErbHelper.asset_link(asset, prefix)
    if (prefix == 'js')
      return "<script type=\"text/javascript\" src=\"{{.RootURL}}/assets/#{asset}\"></script>"
    elsif (prefix == 'css')
      return "<link rel=\"stylesheet\" type=\"text/css\" src=\"{{.RootURL}}/assets/#{asset}\">"
    end
  end

  def ErbHelper.each_compiled_debug_asset(bundles, sproc_env)
    each_compiled_asset(bundles, sproc_env) do |comp_file, prefix, assets|
      assets.to_a.each do |asset|
        # strip filename.css.foo.bar.css multiple extensions, but maintain the base directory of the file
        realname = asset.pathname.basename.to_s.split(".")[0..1].join(".")
        nested = File.dirname(asset.logical_path)

        if nested == "."
          rel_path = File.join(prefix, realname)
        else
          rel_path = File.join(prefix, nested, realname)
        end
        
        yield(rel_path, prefix) if block_given?
      end
    end
  end

  def ErbHelper.each_compiled_asset(bundles, sproc_env)
    bundles.each do |bundle|
      assets = sproc_env.find_asset(bundle)

      # drop all extentions except the first
      realname = assets.pathname.basename.to_s.split(".")[0..1].join(".")
      prefix = File.extname(realname).split('.').last
      out_file = File.join(prefix, realname)

      yield(out_file, prefix, assets) if block_given?
    end
  end
end
