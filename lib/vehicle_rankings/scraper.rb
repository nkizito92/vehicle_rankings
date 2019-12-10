class Scraper 
    def self.scrape_vehicles 
        scraped_car_info = {car_nodes: [], price_nodes: [], url_nodes: []}
        doc = Nokogiri::HTML(open("https://www.enterprisecarsales.com/list/buy-a-car/models=Fiat,Genesis,Jaguar+sort=make_sidebar,asc,,model_sidebar,asc+viewType=overview"))
        name = doc.xpath("//div[@itemprop='name']").text.gsub("201", "+201").split("+")[1..-1]
        price = doc.xpath("//div[@class='pricing_value_3 value']").text.gsub("$", " $").split(" ").collect {|pri| pri.gsub(/[$,]/, "")}
        url = doc.css("div.overflow-hidden").map{|one| one.css("a").attribute("href").value}
        scraped_car_info[:price_nodes] = price
        scraped_car_info[:car_nodes] = name 
        scraped_car_info[:url_nodes] = url 
        scraped_car_info
    end 

end 