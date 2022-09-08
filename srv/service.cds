using {ZSB_UI_TRAVEL_U as external} from './external/ZSB_UI_TRAVEL_U';

service TravelService {
    @Capabilities : {
        Insertable : false,
        Updatable  : true,
        Deletable  : false
    }
    @cds.persistence.skip
    entity Travel   as projection on external.Travel {
        key TravelID,
            AgencyID,
            AgencyName,
            CustomerID,
            CustomerName,
            Status,
            Memo,
            LastChangedAt ,
            to_Booking as bookings: redirected to Bookings
    } actions {
        action statusBooked() returns Travel
    };

    @cds.persistence.skip
    entity Bookings as projection on external.Booking {
        key TravelID,
        key BookingID,
            CustomerID,
            CustomerName,
            AirlineID,
            AirlineName
    };

}
