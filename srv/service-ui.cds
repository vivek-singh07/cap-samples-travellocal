using TravelService from './service';

annotate TravelService.Travel with {
    TravelID   @title : 'Travel ID';
    AgencyID   @(
        title                  : 'Agency',
        Common.Text            : AgencyName,
        Common.TextArrangement : #TextOnly
    );
    CustomerID @(
        title                  : 'Customer',
        Common.Text            : CustomerName,
        Common.TextArrangement : #TextOnly
    );
    Status     @title : 'Status';
}

annotate TravelService.Bookings with {
    TravelID   @(UI.Hidden);
    BookingID  @title : 'Booking ID';
    CustomerID @(
        title                  : 'Customer',
        Common.Text            : CustomerName,
        Common.TextArrangement : #TextOnly
    );
    AirlineID  @(
        title                  : 'Customer',
        Common.Text            : AirlineName,
        Common.TextArrangement : #TextOnly
    );

}

annotate TravelService.Travel with @(UI : {
    HeaderInfo      : {
        TypeName       : 'Travel',
        TypeNamePlural : 'Travels',
        Title          : {
            $Type : 'UI.DataField',
            Value : TravelID
        }
    },
    SelectionFields : [Status],
    LineItem        : [
        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'TravelService.statusBooked',
            Label  : 'Set Status Booked'
        },
        {   $Type : 'UI.DataField',
            Value : TravelID
        },
        {   $Type : 'UI.DataField',
            Value : AgencyID
        },
        {   $Type : 'UI.DataField',
            Value : CustomerID
        },
        {   $Type : 'UI.DataField',
            Value : Status
        }
    ],
    Facets          : [{
        $Type  : 'UI.ReferenceFacet',
        Target : 'bookings/@UI.LineItem',
        Label  : 'Booking Facet'
    } ]
});

annotate TravelService.Bookings with @(UI : {
    HeaderInfo : {
        TypeName       : 'Booking',
        TypeNamePlural : 'Bookings',
        Title          : {
            $Type : 'UI.DataField',
            Value : BookingID
        }
    },
    LineItem   : [
        {
            $Type : 'UI.DataField',
            Value : BookingID,
        },
        {
            $Type : 'UI.DataField',
            Value : CustomerID,
        },
        {
            $Type : 'UI.DataField',
            Value : AirlineID,
        }
    ]
});
