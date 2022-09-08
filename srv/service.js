const cds = require('@sap/cds')

class TravelService extends cds.ApplicationService {
    async init() {
        const srv = await cds.connect.to('ZSB_UI_TRAVEL_U');
        const { Travel, Bookings } = this.entities;

        this.on('READ', [Travel, Bookings], async req => {
            return await srv.tx(req).run(req.query)
        })

        this.on('statusBooked', Travel, async ( { params: [{ TravelID }] } ) => {
            // get etag
            const travel = await srv.run(SELECT.from(Travel,TravelID).columns(['TravelID']))
            // prepare header
            const headers = {"If-Match": travel.$metadata.etag}
            // Patch request
            const query = [ UPDATE(Travel, TravelID).with({
                Status: 'P' }) ]
            // send request    
            await srv.send({query, headers })
            return await srv.run(SELECT.from(Travel, TravelID))
        })

        await super.init()
    }
}

module.exports = { TravelService }