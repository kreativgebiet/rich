module Rich
	class DisplayController < ApplicationController
		def show
			if params[:id]
				file = RichFile.find(params[:id])
				if file.blank?
					render :text => "File not found"
				else
					if params[:style] && file.rich_file.styles.include?(params[:style].to_sym)
						@url = file.rich_file.url(params[:style].to_sym)
					else
						@url = file.rich_file.url
					end
				end

				render :layout => false
			else 
				render :text => "File not found"
			end			
		end
	end
end