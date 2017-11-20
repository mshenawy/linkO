class PagesController < ApplicationController

	def welcome
		  if logged_in?
      @micropost  = current_user.microposts.build
      @message  = current_user.messages.build
      @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 10)
    end
	end

	def about
		@title = 'عن LinkO' ; 
		@content = 'linkO يسهل عليك الوصول الى الأفكار , الأخبار العاجله , العروض,... وغيرها ، من مصادر متعدده فى مكان واحد فقط .
مهمتنا مساعدة المجتمع العربى من استكشاف العالم الذى يعيشون فيه , وتمكين مجتمعنا من الإزدهار..
' ;
	end

	def help
  	end

    def contact
    end
end
