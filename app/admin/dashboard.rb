ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

    content :title => proc{ I18n.t("active_admin.dashboard") } do        
        columns do
        
            column do
                panel "Current Showtimes" do
                    ul do
                        Showtime.current.map do |showtime|
                            li link_to(showtime.name, admin_showtime_path(showtime))
                        end
                    end
                end
            end

            column do
                panel "Current Movies" do
                    ul do
                        Movie.current.map do |movie|
                            li link_to(movie.name, admin_showtime_path(movie))
                        end
                    end
                end
            end

        end


        columns do
        
            column do
                panel "Recently Added Showtimes" do
                    ul do
                        Showtime.recent.map do |showtime|
                            li link_to(showtime.name, admin_showtime_path(showtime))
                        end
                    end
                end
            end

            column do
                panel "Recently Added Movies" do
                    ul do
                        Movie.recent.map do |movie|
                            li link_to(movie.name, admin_showtime_path(movie))
                        end
                    end
                end
            end

        end
    end
end