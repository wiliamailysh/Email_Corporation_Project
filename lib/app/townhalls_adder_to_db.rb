class AdderDatabase

    def initialize(container)
        File.write("../.././db/townhalls.json", container.to_json)
    end

end
